(use-package telephone-line
  :init
  ;; Need to display telephone-line in *Messages* buffer
  (defun recreate-message-buffer ()
    (cl-flet ((buffer-string* (buffer)
                              (with-current-buffer buffer
                                (buffer-string))))
      (let ((msg (buffer-string* "*Messages*")))
        (kill-buffer "*Messages*")
        (message msg))))

  (add-hook 'after-init-hook #'recreate-message-buffer)

  ;; :hook (after-init . telephone-line-mode)

  :config
  ;; To create custom segments
  (require 'telephone-line-utils)

  ;; Set subseparator
  ;; TODO: function to choose separator by name
  (if window-system
      (progn
        (setq telephone-line-secondary-left-separator 'telephone-line-identity-hollow-left)
        (setq telephone-line-secondary-right-separator 'telephone-line-identity-hollow-right)))

  ;;; Custom segments

  ;; Display major mode
  ;; TODO: rewrite with var/macro
  (telephone-line-defsegment* my-major-mode-segment ()
    (let ((mode (cond
                 ((string= mode-name "Fundamental") "text")
                 ((string= mode-name "Emacs-Lisp") "elisp")
                 ((string= mode-name "Javascript-IDE") "js")
                 ((string= mode-name "Javascript-IDE") "js")
                 ((string= mode-name "undo-tree-visualizer") "undotree")
                 (t (downcase mode-name)))))
      ;; (propertize mode 'face `(:foreground "#9d81ba")))) ;; galaxy
      (propertize mode 'face `font-lock-string-face)))

  ;; TODO: add raise or v-adjust
  (telephone-line-defsegment* my-major-mode-segment-icon ()
    (let ((mode (cond
                 ((string= mode-name "Fundamental") "text")
                 ((string= mode-name "Emacs-Lisp") "elisp")
                 ((string= mode-name "Javascript-IDE") "js")
                 ((string= mode-name "Javascript-IDE") "js")
                 ((string= mode-name "undo-tree-visualizer") "undotree")
                 (t (downcase mode-name))))
          (icon (all-the-icons-icon-for-mode major-mode)))
      (concat
       (when
           (and (not (eq major-mode (all-the-icons-icon-for-mode major-mode)))
                (telephone-line-selected-window-active))
         (format "%s "
                 (propertize icon
                             'help-echo (format "Major-mode: `%s'" major-mode)
                             'display '(raise 0)
                             'face `(:height 1.0
                                             :family ,(all-the-icons-icon-family-for-mode major-mode)
                                             :inherit font-lock-string-face))))
       (propertize mode 'face `font-lock-string-face))))

  (telephone-line-defsegment my-evil-segment ()
    "Display evil state as text symbol."
    (let ((tag (cond
                ((string= evil-state "normal")    ":")
                ((string= evil-state "insert")    ">")
                ((string= evil-state "replace")   "r")
                ((string= evil-state "visual")    "!")
                ((string= evil-state "operator")  "=")
                ((string= evil-state "motion")    "m")
                ((string= evil-state "emacs")     "Emacs")
                (t "-"))))
      (format " %s" tag)))

  (telephone-line-defsegment my-evil-segment-icons ()
    "Display evil state as icon with all-the-icons."
    (let ((tag (cond
                ((string= evil-state "normal")    (all-the-icons-faicon "magic"))
                ((string= evil-state "insert")    (all-the-icons-faicon "pencil"))
                ((string= evil-state "replace")   (all-the-icons-faicon "eraser"))
                ((string= evil-state "visual")    (all-the-icons-faicon "clipboard"))
                ;; TODO:
                ;; ((string= evil-state "operator")  (all-the-icons-faicon "dot-circle-o"))
                ((string= evil-state "motion")    (all-the-icons-faicon "angle-double-right"))
                ((string= evil-state "emacs")     (all-the-icons-fileicon "org"))
                (t "-"))))
      (format " %s" tag)))

  ;; Display buffer name
  (telephone-line-defsegment my-buffer-segment ()
    (format "%s %s"
            (propertize (all-the-icons-fileicon "elisp")
                        'face `(:family ,(all-the-icons-fileicon-family) :height 1.0)
                        'display '(raise 0.0))
            (propertize
             (format "%s"
                     (telephone-line-raw mode-line-buffer-identification t)))))
  ;; 'face `(:foreground ,fg-color))))

  ;; Display current position in a buffer
  ;; (telephone-line-defsegment my-position-segment ()
  ;;   (if (telephone-line-selected-window-active)
  ;;       (if (eq major-mode 'paradox-menu-mode)
  ;;           (telephone-line-trim (format-mode-line mode-line-front-space))
  ;;         '(" %3l,%2c "))))

  (declare-function column-number-at-pos "env-fu")

  (telephone-line-defsegment my-position-segment ()
    (let ((line (line-number-at-pos (point)))
          (column (current-column)))
      (format " %3d:%2d " line column)))

  ;; Exclude some buffers in modeline
  (defvar modeline-ignored-modes nil
    "List of major modes to ignore in modeline")

  (setq modeline-ignored-modes '("Dashboard"
                                 "Warnings"
                                 "Compilation"
                                 "EShell"
                                 "Debugger"
                                 "Quickrun"
                                 "REPL"
                                 "IELM"
                                 "Messages"))

  ;; Display modified status
  (telephone-line-defsegment my-modified-status-segment ()
    (when (and (buffer-modified-p) (not (member mode-name modeline-ignored-modes)) (not buffer-read-only))
      (propertize "+" 'face `(:foreground "#85b654"))))

  ;; Display read-only status
  (telephone-line-defsegment my-read-only-status-segment ()
    (when buffer-read-only
      ;; (propertize "ro" 'face `(:foreground "#dbac66"))
      (propertize (all-the-icons-octicon "key")
                  'face `(:family ,(all-the-icons-octicon-family) :height 1.0 :foreground "dim gray")
                  'display '(raise 0.0))))

  ;; Display encoding system
  (telephone-line-defsegment my-coding-segment ()
    (let* ((code (symbol-name buffer-file-coding-system))
           (eol-type (coding-system-eol-type buffer-file-coding-system))
           (eol (cond
                 ((eq 0 eol-type) "unix")
                 ((eq 1 eol-type) "dos")
                 ((eq 2 eol-type) "mac")
                 (t "-"))))
      (format  "%s " eol)))

  ;; TODO:
  ;; Hide vc backend in modeline
  (defadvice vc-mode-line (after strip-backend () activate)
    (when (stringp vc-mode)
      (let ((my-vc (replace-regexp-in-string "^ Git." "" vc-mode)))
        (setq vc-mode my-vc))))

  ;; Display current branch
  ;; TODO: move raise and etc into var
  (telephone-line-defsegment my-vc-segment ()
    (when (and vc-mode (telephone-line-selected-window-active))
      ;; double format to prevent warnings in '*Messages*' buffer
      (format "%s %s"
              (propertize (all-the-icons-octicon "git-branch")
                          'face `(:family ,(all-the-icons-octicon-family) :height 1.0 :foreground ,(face-foreground 'font-lock-variable-name-face))
                          'display '(raise 0.0))
              (propertize
               (format "%s"
                       (telephone-line-raw vc-mode t))
               'face `(:foreground ,(face-foreground 'font-lock-variable-name-face))))))


  ;; ;; TODO: free visual selection
  ;; ;; TODO: the segment doesn't update in real-time
  (telephone-line-defsegment selection-info ()
    "Information about the size of the current selection, when applicable.
  Supports both Emacs and Evil cursor conventions."
    (when (or mark-active
              (and (bound-and-true-p evil-local-mode)
                   (eq 'visual evil-state)))
      (let* (
             ;; (lines (count-lines (region-beginning) (min (1+ (region-end)) (point-max))))
             (lines (count-lines (region-beginning) (region-end)))
             (chars (- (1+ (region-end)) (region-beginning)))
             (cols (1+ (abs (- (column-number-at-pos (region-end))
                               (column-number-at-pos (region-beginning))))))
             (evil (and (bound-and-true-p evil-state) (eq 'visual evil-state)))
             (rect (or (bound-and-true-p rectangle-mark-mode)
                       (and evil (eq 'block evil-visual-selection))))
             (multi-line (or (> lines 1) (and evil (eq 'line evil-visual-selection)))))
        (cond
         (rect (format "%d×%d" lines (if evil cols (1- cols))))
         (multi-line (format "%dL" lines))
         (t (format "%d" (if evil chars (1- chars))))))))


  (telephone-line-defsegment my-flycheck-segment ()
    ;; TODO: split errors and warnings
    (when (boundp 'flycheck-last-status-change)
      (pcase flycheck-last-status-change
        ('finished (if flycheck-current-errors
                       (let-alist (flycheck-count-errors flycheck-current-errors)
                         (let ((sum (+ (or .error 0) (or .warning 0))))
                           (format " %s: %s"
                                   (if .error "errors" "warnings")
                                   (number-to-string sum))))
                     ;; TODO:
                     " succeed"))
        ('running     " working...")
        ('no-checker  "")
        ('errored     " error")
        ('interrupted " interrupted"))))

  (telephone-line-defsegment my-words-count-segment ()
    (format "%d" (count-words (point-min) (point-max))))

  (setq telephone-line-primary-left-separator 'telephone-line-tan-left)
  (setq telephone-line-primary-right-separator 'telephone-line-tan-right)

  ;; Set mode-line height
  (setq telephone-line-height 30)

  ;; Left edge
  ;; TODO: gray background for buffer and mode segment in inactive line
  (setq telephone-line-lhs
        '((evil   . (my-evil-segment))
          ;; (accent . (telephone-line-filesize-segment))
          (nil    . (telephone-line-projectile-buffer-segment))
          (nil    . (my-modified-status-segment))
          (nil    . (my-read-only-status-segment))
          (nil    . (selection-info))))
  ;; (nil    . (my-flycheck-segment))))

  ;; Right edge
  (setq telephone-line-rhs
        '((nil    . (my-vc-segment))
          (accent . (my-position-segment))
          (nil    . (my-major-mode-segment))
          ;; (nil    . (my-major-mode-segment-icon))
          (accent . ((my-coding-segment :active)))))

  (telephone-line-mode 1))

(provide 'core-modeline)
