(use-package julia-mode
  :mode (("\\.jl\\'" . julia-mode))
  :config
  (add-hook 'julia-mode-hook #'lsp))

(use-package lsp-julia
  :straight (:host github :repo "non-Jedi/lsp-julia")
  :after julia-mode)

(provide 'layer-julia)
