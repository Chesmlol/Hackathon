async function subAns(id) {
    const v = document.getElementById("ans_" + id).value;
    try {
        const res = await fetch("/submit", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ id: id, answer: v }) });
        const d = await res.json();
        showNotification(d.msg, d.success ? "success" : "error");
        if (d.success) setTimeout(() => { location.reload(); }, 800);
    } catch (e) {
        showNotification(t("js.submit_answer_error"), "error");
    }
}