(defun felipe/comment-box (b e)
  "Draw a box comment around the region but arrange for the region to extend to at least the fill column. Place the point after the comment box."
  (interactive "r")
  (let ((e (copy-marker e t)))
    (goto-char b)
    (end-of-line)
    (insert-char ?  (- fill-column (current-column)))
    (comment-box b e 1)
    (goto-char e)
    (set-marker e nil)))

(provide 'core-misc)
