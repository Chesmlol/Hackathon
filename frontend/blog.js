document.addEventListener('DOMContentLoaded', function () {
    document.body.addEventListener('click', async function (e) {
        const btn = e.target.closest('.blog-vote .vote-btn');
        if (!btn) return;

        const voteCol = btn.closest('.blog-vote');
        const postId = voteCol.getAttribute('data-post-id');
        const vote = parseInt(btn.getAttribute('data-vote'), 10);

        try {
            const res = await fetch('/api/blog/vote', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ post_id: postId, vote: vote })
            });
            const data = await res.json();
            if (!data.success) {
                if (typeof showNotification === 'function') {
                    showNotification(data.msg || 'Please log in to vote.', 'error');
                }
                return;
            }
            const scoreEl = voteCol.querySelector('.vote-score');
            if (scoreEl) scoreEl.textContent = data.score;
            const upBtn = voteCol.querySelector('.vote-up');
            const downBtn = voteCol.querySelector('.vote-down');
            if (upBtn) upBtn.classList.toggle('active', data.user_vote === 1);
            if (downBtn) downBtn.classList.toggle('active', data.user_vote === -1);
        } catch (err) {
            if (typeof showNotification === 'function') {
                showNotification('Error casting vote.', 'error');
            }
        }
    });
});
