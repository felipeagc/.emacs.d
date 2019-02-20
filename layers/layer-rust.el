(require 'layer-lsp)

;; Rust-mode
(use-package rust-mode)


;; Key bindings

(felipe/leader-def 'normal rust-mode-map
  "mf" 'rust-format-buffer)

(general-def 'normal rust-mode-map
  "gd" 'xref-find-definitions
  "gD" 'xref-find-definitions-other-window)

(provide 'layer-rust)
