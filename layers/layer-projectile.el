;; Projectile
(use-package projectile
  :init
  ;; (setq projectile-require-project-root nil)
  :config
  (projectile-global-mode))


;; Key bindings
(felipe/leader-def
  :keymaps 'normal
  "a" 'projectile-find-other-file
  "A" 'projectile-find-other-file-other-window

  "pa" 'projectile-add-known-project)

(provide 'layer-projectile)
