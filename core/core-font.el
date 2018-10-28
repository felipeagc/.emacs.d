(setq felipe/default-font-size-pt 12
      felipe/font-size-pt felipe/default-font-size-pt)

(add-to-list 'default-frame-alist '(font . "-CYEL-Iosevka-semibold-normal-normal-*-16-*-*-*-d-0-iso10646-1"))

(defun felipe/font-size-adj (&optional arg)
  (interactive "p")
  (if (= arg 0)
      (setq felipe/font-size-pt felipe/default-font-size-pt)
    (setq felipe/font-size-pt (+ felipe/font-size-pt arg)))
  ;; The internal font size value is 10x the font size in points unit.
  ;; So a 10pt font size is equal to 100 in internal font size value.
  (set-face-attribute 'default nil :height (* felipe/font-size-pt 10)))

(defun felipe/font-size-incr  () (interactive) (felipe/font-size-adj +1))
(defun felipe/font-size-decr  () (interactive) (felipe/font-size-adj -1))
(defun felipe/font-size-reset () (interactive) (felipe/font-size-adj 0))

(felipe/font-size-reset)

(provide 'core-font)
