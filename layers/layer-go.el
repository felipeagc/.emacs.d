;; Go mode
(use-package go-mode
  :mode (("\\.go\\'" . go-mode))
  :config
  (use-package go-eldoc
    :config
    (add-hook 'go-mode-hook 'go-eldoc-setup))

  (use-package company-go
    :after company))


;; Key bindings
(felipe/leader-def 'normal go-mode-map
  "mf" 'gofmt
  "mi" '(go-import-add
         :which-key "add imports"))

(general-def 'normal go-mode-map
  "K" 'godoc-at-point
  "gd" 'godef-jump
  "gD" 'godef-jump-other-window)

(provide 'layer-go)
