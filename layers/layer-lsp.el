(require 'layer-flycheck)
(require 'layer-company)

;; LSP mode
(use-package lsp-mode
  :after flycheck
  :init
  (setq lsp-highlight-symbol-at-point nil)
  :config
  (use-package lsp-ui
    :init
    (setq lsp-ui-sideline-enable nil
          lsp-ui-doc-include-signature nil
          lsp-ui-doc-enable nil)
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode))
  (use-package company-lsp
    :after company
    :init
    (setq company-lsp-async t)
    ;; (setq company-transformers nil
    ;;       company-lsp-async t
    ;;       company-lsp-cache-candidates nil
    ;;       company-lsp-enable-snippet nil)
    :config
    (push 'company-lsp company-backends)))

(provide 'layer-lsp)
