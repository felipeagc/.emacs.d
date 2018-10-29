(use-package dashboard
  :init
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
        dashboard-startup-banner 'logo)
  :config
  (dashboard-setup-startup-hook))

(provide 'layer-dashboard)
