async function runSage() {
    const code = document.getElementById("sage-code").value;
    const outputElement = document.getElementById("sage-output");
    
    outputElement.textContent = "Running...";

    try {
        const response = await fetch("/run", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ code: code })
        });

        const data = await response.json();
        if (data.success) {
            outputElement.textContent = data.output || data.error || "No output";
        } else {
            outputElement.textContent = "Error: " + data.error;
        }
    } catch (error) {
        outputElement.textContent = "Error connecting to backend: " + error.message;
    }
}

function clearSage() {
    document.getElementById("sage-code").value = "";
    document.getElementById("sage-output").textContent = "";
}