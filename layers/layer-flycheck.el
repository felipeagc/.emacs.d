;; Flycheck
(use-package flycheck
  :config
  (global-flycheck-mode)) 


;; Flycheck hover toolip
(use-package flycheck-pos-tip
  :after flycheck
  :config
  (setq flycheck-pos-tip-timeout 60)
  (flycheck-pos-tip-mode))


;; Key bindings
(felipe/leader-def
  :keymaps 'normal
  "en" 'flycheck-next-error
  "ep" 'flycheck-previous-error)

(provide 'layer-flycheck)
