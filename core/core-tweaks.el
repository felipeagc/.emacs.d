;; No littering
(use-package no-littering
  :config
  ;; auto-save and backup files in no-littering directory
  (setq
   auto-save-file-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))
   backup-directory-alist         `((".*" . ,(no-littering-expand-var-file-name "backups")))
   custom-file (no-littering-expand-etc-file-name "custom.el")))


;; Better yes/no questions
;; This makes emacs accept only y/n as answers.
(fset 'yes-or-no-p 'y-or-n-p)

(provide 'core-tweaks)
