(require 'layer-flycheck)
(require 'layer-company)
(require 'layer-snippets)

;; LSP mode
(use-package lsp-mode
  :commands lsp
  :after flycheck
  :init
  (setq lsp-eldoc-hook '(lsp-hover)
        lsp-prefer-flymake nil)
  :config
  (use-package lsp-ui
    :commands lsp-ui-mode
    :init
    (setq lsp-ui-sideline-enable nil
          lsp-ui-doc-include-signature nil
          lsp-ui-doc-enable nil)
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode))
  (use-package company-lsp
    :commands company-lsp
    :after company
    :init
    (setq company-lsp-async t
          company-lsp-enable-snippet t
          company-lsp-cache-candidates nil)
    ;; (setq company-transformers nil
    ;;       company-lsp-async t
    ;;       company-lsp-cache-candidates nil
    ;;       company-lsp-enable-snippet nil)
    :config
    (push 'company-lsp company-backends)))

(provide 'layer-lsp)
