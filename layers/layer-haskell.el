;; Intero
(use-package intero
  :mode (("\\.hs\\'" . intero-mode))
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))


(provide 'layer-haskell)
