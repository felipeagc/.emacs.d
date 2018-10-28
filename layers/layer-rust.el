(require 'layer-lsp)

;; Rust-mode
(use-package rust-mode)


;; LSP
(use-package lsp-rust
  :after lsp-mode
  :init
  (setq lsp-rust-rls-command '("rustup" "run" "stable" "rls"))
  :config
  (lsp-rust-set-config "wait_to_build" 200)
  (add-hook 'rust-mode-hook #'lsp-rust-enable)
  (add-hook 'rust-mode-hook #'flycheck-mode))


;; Key bindings

(felipe/leader-def 'normal rust-mode-map
  "mf" 'rust-format-buffer)

(general-def 'normal rust-mode-map
  "gd" 'xref-find-definitions
  "gD" 'xref-find-definitions-other-window)

(provide 'layer-rust)
