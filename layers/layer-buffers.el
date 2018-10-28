;; Smarter buffer navigation
(defun felipe/user-buffer-q ()
  "Return t if current buffer is a user buffer, else nil.
   Typically, if buffer name starts with *, it's not considered a user buffer.
   This function is used by buffer switching command and close buffer command, so that next buffer shown is a user buffer.
     You can override this function to get your idea of 'user buffer'."
  (interactive)
  (not (or (string-equal "*" (substring (buffer-name) 0 1))
           (string-equal major-mode "dired-mode")
           (string-prefix-p "magit" (buffer-name)))))

(defun felipe/next-user-buffer ()
  "Switch to the next user buffer.
   'user buffer' is determined by 'xah-user-buffer-q'."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (felipe/user-buffer-q))
          (progn (next-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun felipe/previous-user-buffer ()
  "Switch to the previous user buffer.
   'user buffer' is determined by 'xah-user-buffer-q'."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (felipe/user-buffer-q))
          (progn (previous-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))


;; Key bindings
(felipe/leader-def
  :keymaps 'normal
  "bn" 'felipe/next-user-buffer
  "bp" 'felipe/previous-user-buffer)

(provide 'layer-buffers)
