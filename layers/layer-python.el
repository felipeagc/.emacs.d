(require 'layer-lsp)

;; LSP
(use-package lsp-python
  :after lsp-mode
  :config
  (add-hook 'python-mode-hook #'lsp-python-enable))


;; Key bindings
(felipe/leader-def 'normal python-mode-map
  "mf" 'lsp-format-buffer)

(general-def 'normal python-mode-map
  "K" 'lsp-info-under-point
  "gd" 'xref-find-definitions
  "gd" 'xref-find-definitions-other-window)

(provide 'layer-python)
