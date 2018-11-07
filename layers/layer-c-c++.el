(require 'layer-lsp)


(defun felipe/cquery-hook ()
  (when (or (eq major-mode 'c-mode)
            (eq major-mode 'c++-mode))
    (lsp-cquery-enable)))

;; Cquery
(use-package cquery
  :hook ((c-mode . felipe/cquery-hook)
         (c++-mode . felipe/cquery-hook))
  :init
  (setq cquery-executable "/usr/bin/cquery"
        ;; cquery-extra-args '("--log-file=/tmp/cq.log")
        ;; cquery-sem-highlight-method 'font-lock
        ;; cquery-extra-init-params '(:completion (:detailedLabel t))
        ))


;; CMake
(use-package cmake-mode)


;; Indentation
(defun felipe/c-indent-hook ()
  (interactive)
  (setq tab-width 2
        evil-shift-width 2
        c-basic-offset 2)
  (c-set-offset 'brace-list-intro '+)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close 0))

(add-hook 'c-mode-common-hook 'felipe/c-indent-hook)


;; Key bindings
(felipe/leader-def 'normal c-mode-map
  "mf" 'lsp-format-buffer
  "mr" 'lsp-rename)
(felipe/leader-def 'normal c++-mode-map
  "mf" 'lsp-format-buffer
  "mr" 'lsp-rename)

(general-def 'normal c-mode-map
  "gd" 'lsp-ui-peek-find-definitions)
(general-def 'normal c++-mode-map
  "gd" 'lsp-ui-peek-find-definitions)

(provide 'layer-c-c++)
