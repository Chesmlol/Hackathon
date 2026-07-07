/* ChanceField notification toasts — replaces window.alert() with a
   dismissable pop-up banner at the top of the page. */
(function () {
    function ensureContainer() {
        let container = document.getElementById('cf-toast-container');
        if (!container) {
            container = document.createElement('div');
            container.id = 'cf-toast-container';
            container.style.cssText = [
                'position:fixed', 'top:20px', 'left:50%', 'transform:translateX(-50%)',
                'z-index:9999', 'display:flex', 'flex-direction:column', 'gap:10px',
                'align-items:center', 'pointer-events:none', 'width:100%', 'max-width:90vw'
            ].join(';');
            document.body.appendChild(container);
        }
        return container;
    }

    const THEME = {
        success: '#00ff66',
        error: '#ff3030',
        info: '#00ff66'
    };

    window.showNotification = function (message, type) {
        type = type && THEME[type] ? type : 'info';
        const color = THEME[type];
        const container = ensureContainer();

        const toast = document.createElement('div');
        toast.setAttribute('role', 'alert');
        toast.textContent = message;
        toast.style.cssText = [
            'pointer-events:auto', 'background:#000', `border:2px solid ${color}`,
            `color:${color}`, "font-family:'Courier New', monospace", 'font-size:0.95em',
            'padding:12px 20px', 'border-radius:4px', `box-shadow:0 0 14px ${color}66`,
            'opacity:0', 'transform:translateY(-16px)',
            'transition:opacity 0.25s ease, transform 0.25s ease',
            'text-align:center', 'cursor:pointer'
        ].join(';');

        const dismiss = () => {
            toast.style.opacity = '0';
            toast.style.transform = 'translateY(-16px)';
            setTimeout(() => toast.remove(), 250);
        };
        toast.addEventListener('click', dismiss);

        container.appendChild(toast);
        requestAnimationFrame(() => {
            toast.style.opacity = '1';
            toast.style.transform = 'translateY(0)';
        });

        setTimeout(dismiss, 3500);
    };
})();