(use-package restart-emacs
  :init
  (setq restart-emacs-restore-frames nil))


;; Key bindings
(felipe/leader-def
  :keymaps 'normal
  "qr" 'restart-emacs)

(provide 'layer-restart)
