(setq js-indent-level 2)

(add-hook 'js-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq evil-shift-width 2)))

(use-package tide
  :config
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    ;; (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1))

  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)

  ;; formats the buffer before saving
  ;; (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'js-mode-hook #'setup-tide-mode)
  ;; configure javascript-tide checker to run after your default javascript checker
  (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

  (add-hook 'typescript-mode-hook #'setup-tide-mode))


;; Key bindings
(felipe/leader-def 'normal js-mode-map
  "mf" 'tide-format
  "mr" '(tide-rename-symbol
         :which-key "rename symbol"))

(general-def 'normal js-mode-map
  "K" 'tide-documentation-at-point
  "gd" 'xref-find-definitions
  "gD" 'xref-find-definitions-other-window)

(felipe/leader-def 'normal typescript-mode-map
  "mf" 'tide-format
  "mr" '(tide-rename-symbol
         :which-key "rename symbol"))

(general-def 'normal typescript-mode-map
  "K" 'tide-documentation-at-point
  "gd" 'xref-find-definitions
  "gD" 'xref-find-definitions-other-window)

(provide 'layer-js)
