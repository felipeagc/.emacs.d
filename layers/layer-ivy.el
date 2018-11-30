;; Ivy
(use-package ivy
  :config
  (ivy-mode 1)
  (use-package ivy-xref
    :init
    (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)))


;; Counsel
(use-package counsel
  :after ivy
  :init
  (setenv "FZF_DEFAULT_COMMAND"
          "rg --files --follow")
  (setq counsel-find-file-ignore-regexp
        (concat
         ;; File names beginning with # or .
         "\\(?:\\`[#.]\\)"
         ;; File names ending with # or ~
         "\\|\\(?:\\`.+?[#~]\\'\\)"))
  :config
  (use-package counsel-projectile
    :after projectile
    :config
    (counsel-projectile-mode)))


;; Key bindings
(felipe/leader-def
  :keymaps 'normal
  "ff" 'counsel-find-file
  "bb" 'ivy-switch-buffer
  "tt" 'counsel-load-theme

  "ir" 'ivy-resume

  "pp" 'counsel-projectile-switch-project
  "pf" 'counsel-fzf
  "pg" 'counsel-projectile-rg)

(provide 'layer-ivy)
