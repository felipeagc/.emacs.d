;; All-the-icons
(use-package all-the-icons
  :init
  (setq inhibit-compacting-font-caches t))


;; Theme
(use-package kaolin-themes
  :config
  (load-theme 'kaolin-dark t))


;; Rainbow delimeters
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(provide 'core-theme)
