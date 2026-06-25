async function subAns(id) {
    const v = document.getElementById("ans_" + id).value;
    try {
        const res = await fetch("/submit", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ id: id, answer: v }) });
        const d = await res.json();
        alert(d.msg);
        if (d.success) window.location.href = "/practice";
    } catch (e) { alert("Error"); }
}