(require 'layer-lsp)


;; Cquery
(use-package cquery
  :init
  (setq cquery-executable "/usr/bin/cquery"
        ;; cquery-extra-args '("--log-file=/tmp/cq.log")
        ;; cquery-sem-highlight-method 'font-lock
        ;; cquery-extra-init-params '(:completion (:detailedLabel t))
        )
  :config
  (add-hook 'c-mode-hook #'lsp)
  (add-hook 'c++-mode-hook #'lsp))


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


;; Formatting
(use-package clang-format)


;; Bison / Flex
(use-package bison-mode
  :straight (:host github :repo "felipeagc/bison-mode")
  :init
  (setq bison-rule-separator-column 2
        bison-rule-enumeration-column 4
        bison-all-electricity-off t))


;; Key bindings
(felipe/leader-def 'normal c-mode-map
  "mf" 'clang-format-buffer
  "mr" 'lsp-rename)
(felipe/leader-def 'normal c++-mode-map
  "mf" 'clang-format-buffer
  "mr" 'lsp-rename)

(felipe/leader-def 'normal c++-mode-map
  "dd" 'gud-gdb
  "db" 'gud-break
  "dr" 'gud-remove
  "dn" 'gud-next
  "ds" 'gud-step
  "dp" 'gud-print
  "dR" 'gud-run)

(general-def 'normal c-mode-map
  "gd" 'lsp-ui-peek-find-definitions)
(general-def 'normal c++-mode-map
  "gd" 'lsp-ui-peek-find-definitions)

(provide 'layer-c-c++)
