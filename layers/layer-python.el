(require 'layer-lsp)


;; Key bindings
(felipe/leader-def 'normal python-mode-map
  "mf" 'lsp-format-buffer)

(general-def 'normal python-mode-map
  "K" 'lsp-info-under-point
  "gd" 'xref-find-definitions
  "gd" 'xref-find-definitions-other-window)

(provide 'layer-python)
