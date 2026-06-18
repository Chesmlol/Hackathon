from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import subprocess
import os
import shutil

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class SageRequest(BaseModel):
    code: str

def get_sage_executable():
    # 1. Check if 'sage' is already in PATH
    sage_bin = shutil.which("sage")
    if sage_bin:
        return sage_bin
    
    # 2. Check conda/mamba environments in standard user home locations
    user_home = os.path.expanduser("~")
    possible_paths = [
        os.path.join(user_home, "miniforge3/envs/sage/bin/sage"),
        os.path.join(user_home, "miniconda3/envs/sage/bin/sage"),
        os.path.join(user_home, "anaconda3/envs/sage/bin/sage"),
        os.path.join(user_home, ".conda/envs/sage/bin/sage"),
    ]
    for path in possible_paths:
        if os.path.exists(path) and os.access(path, os.X_OK):
            return path

    # Fallback to "sage" which will raise FileNotFoundError if not found in PATH
    return "sage"

@app.post("/run")
def run_sage(req: SageRequest):

    try:
        sage_exec = get_sage_executable()
        
        wrapper_script = (
            "import sys\n"
            "import ast\n"
            "from sage.repl.preparse import preparse\n"
            "code_str = sys.stdin.read()\n"
            "preparsed = preparse(code_str)\n"
            "tree = ast.parse(preparsed)\n"
            "if tree.body and isinstance(tree.body[-1], ast.Expr):\n"
            "    last_expr = tree.body[-1].value\n"
            "    print_node = ast.Expr(\n"
            "        value=ast.Call(\n"
            "            func=ast.Name(id='print', ctx=ast.Load()),\n"
            "            args=[last_expr],\n"
            "            keywords=[]\n"
            "        )\n"
            "    )\n"
            "    tree.body[-1] = print_node\n"
            "    ast.fix_missing_locations(tree)\n"
            "exec(compile(tree, '<string>', 'exec'), globals())\n"
        )

        result = subprocess.run(
            [sage_exec, "-c", wrapper_script],
            input=req.code,
            capture_output=True,
            text=True,
            timeout=3
        )

        return {
            "success": True,
            "output": result.stdout,
            "error": result.stderr
        }

    except subprocess.TimeoutExpired:
        return {
            "success": False,
            "output": "",
            "error": "Time limit exceeded"
        }
    except FileNotFoundError:
        return {
            "success": False,
            "output": "",
            "error": "SageMath is not installed or not found in PATH."
        }
    except Exception as e:
        return {
            "success": False,
            "output": "",
            "error": f"Internal Error: {str(e)}"
        }