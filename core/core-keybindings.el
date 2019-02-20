;; General
(use-package general
  :config
  (general-create-definer felipe/leader-def
    :prefix "SPC"))


;; Make ESC actually escape stuff
(define-key isearch-mode-map [escape] 'isearch-abort)   ;; isearch
(define-key isearch-mode-map "\e" 'isearch-abort)       ;; \e seems to work better for terminals
(global-set-key [escape] 'keyboard-escape-quit)         ;; everywhere else


;; Zoom keybindings
(define-key global-map (kbd "C-=") 'felipe/font-size-incr)
(define-key global-map (kbd "C--") 'felipe/font-size-decr)
(define-key global-map (kbd "C-0") 'felipe/font-size-reset)


;; ========= Leader bindings =========

;; Misc
(felipe/leader-def
  :keymaps 'normal
  "a" '(nil :which-key "other file")
  "A" '(nil :which-key "other file (other window)"))


;; Toggles
(felipe/leader-def
  :keymaps 'normal
  "t" '(nil :which-key "theme/toggles")
  "tt" '(nil :which-key "themes")
  "tc" '((lambda ()
           (interactive)
           (save-excursion
             (let* ((bounds (bounds-of-thing-at-point 'symbol))
                    (start (car bounds))
                    (end (cdr bounds))
                    (currently-using-underscores-p (progn (goto-char start)
                                                          (re-search-forward "_" end t))))
               (if currently-using-underscores-p
                   (progn
                     (upcase-initials-region start end)
                     (replace-string "_" "" nil start end)
                     (downcase-region start (1+ start)))
                 (replace-regexp "\\([A-Z]\\)" "_\\1" nil (1+ start) end)
                 (downcase-region start (cdr (bounds-of-thing-at-point 'symbol)))))))
         :which-key "toggle word case"))


;; Files
(felipe/leader-def
  :keymaps 'normal
  "f" '(nil :which-key "file")
  "ff" '(nil :which-key "find file")
  "fe" '(nil :which-key "edit")
  "fed" '((lambda ()
            (interactive)
            (find-file "~/.emacs.d/init.el"))
          :which-key "emacs config"))


;; Buffers
(felipe/leader-def
  :keymaps 'normal
  "b" '(nil :which-key "buffer")
  "bb" '(nil :which-key "switch buffer")
  "bd" '(kill-this-buffer
         :which-key "delete buffer")
  "br" '(rename-buffer
         :which-key "rename buffer")
  "bn" '(next-buffer
         :which-key "next buffer")
  "bp" '(previous-buffer
         :which-key "previous buffer")
  "bs" '((lambda ()
           (interactive)
           (switch-to-buffer "*scratch*"))
         :which-key "scratch buffer")
  "bcc" '((lambda ()
            (interactive)
            (mapcar (lambda (buffer)
                      (let ((safe-buffers (list "*scratch*" "*Messages*" "config.org"))
                            (name (buffer-name buffer)))
                        (unless (or
                                 (string-prefix-p "*Org" name)
                                 (member name safe-buffers))
                          (kill-buffer buffer)))) (buffer-list)))
          :which-key "clean buffers"))


;; Window
(felipe/leader-def
  :keymaps 'normal
  "w" '(nil :which-key "window")
  "w/" '(split-window-right
         :which-key "split right")
  "w-" '(split-window-below
         :which-key "split below")
  "wd" '(delete-window
         :which-key "delete window")
  "wb" '(balance-windows
         :which-key "balance windows"))


;; Project
(felipe/leader-def
  :keymaps 'normal
  "p" '(nil :which-key "projectile")
  "pp" '(nil :which-key "switch project")
  "pa" '(nil :which-key "add project")
  "pf" '(nil :which-key "find file (fzf)")
  "pg" '(nil :which-key "grep"))


;; Ivy
(felipe/leader-def
  :keymaps 'normal
  "i" '(nil :which-key "ivy")
  "ir" '(nil :which-key "resume"))


;; Refactoring
(felipe/leader-def
  :keymaps 'normal
  "r" '(nil :which-key "refactor")
  "rs" '(replace-string
         :which-key "replace string"))


;; Git
(felipe/leader-def
  :keymaps 'normal
  "g" '(nil :which-key "git")
  "gg" '(nil :which-key "status"))


;; Errors
(felipe/leader-def
  :keymaps 'normal
  "e" '(nil :which-key "error")
  "en" '(nil :which-key "next error")
  "ep" '(nil :which-key "previous error"))


;; Quitting emacs
(felipe/leader-def
  :keymaps 'normal
  "q" '(nil :which-key "quit")
  "qr" '(nil :which-key "restart emacs/server")
  "qq" '(save-buffers-kill-emacs :which-key "quit emacs/server"))


;; Major mode bindings (just names, really)
(defun felipe/indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(felipe/leader-def
  :keymaps 'normal
  "m" '(nil :which-key "major mode")
  "mr" '(nil :which-key "refactor")
  "mR" '(nil :which-key "quickrun")
  "mf" '(felipe/indent-buffer :which-key "format")
  "mg" '(nil :which-key "go"))

(provide 'core-keybindings)
