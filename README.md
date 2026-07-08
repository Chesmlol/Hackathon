# ChanceField

A Flask + SQLite competitive-math practice platform with a retro terminal
theme, including a built-in judge that runs SageMath submissions.

## Setup

### 1. Flask app

```bash
cd backend
pip install -r requirements.txt
python main.py
```

Serves on http://localhost:6767.

### 2. SageMath (required for the code judge)

The judge (`/submit_code`) shells out to a real `sage` binary to run
submitted code (see `run_code_submission()` in `backend/main.py`). Sage is
a large (multi-GB), compiled scientific-computing stack — it can't be
committed to this repo and can't be installed via `pip`. It has to be
installed separately on every machine that runs this server.

**Recommended: a dedicated conda environment**, so Sage's pinned
dependencies (GSL, MPFR, PARI, GAP, ...) don't drift when you later
`conda install` unrelated packages into `base`:

```bash
conda create -n sage -c conda-forge sage -y
conda activate sage
sage --version   # should print a version, not a traceback
```

Or use `environment.yml` in this repo as a starting point:

```bash
conda env create -f environment.yml
conda activate chancefield-sage
```

`environment.yml` here only pins `sage` itself as a template — once you
have a working install, regenerate it from your actual environment so the
exact dependency versions (GSL, MPFR, etc.) are reproducible on the next
machine:

```bash
conda env export -n chancefield-sage --no-builds > environment.yml
```

### 3. Point the judge at your Sage install

The judge does **not** require `sage` to be on Flask's default `PATH` —
set `SAGE_BINARY` to the full path instead:

```bash
export SAGE_BINARY=/path/to/miniconda3/envs/sage/bin/sage
python backend/main.py
```

If unset, it falls back to whatever `sage` resolves to on `PATH`.

### 4. Deploying to another server

A fresh server needs the same "install Sage separately, point
`SAGE_BINARY` at it" setup as above — either:

- **Conda + `environment.yml`** (above) — simplest, but still a multi-GB
  install step you run once per machine.
- **Docker** — see `Dockerfile`. Builds on the official `sagemath/sagemath`
  image, which ships a tested, working Sage install, avoiding the
  GSL-version-drift problem entirely. This is the more reliable option for
  a real server/production deployment. (Not build-tested in this
  environment — no Docker/network access here — so treat it as a starting
  point and verify it builds before relying on it.)
