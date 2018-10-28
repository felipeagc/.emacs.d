;; Indentation
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq evil-shift-width 2)))

(provide 'layer-elisp)
