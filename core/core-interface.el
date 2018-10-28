;; Which-key
(use-package which-key
  :config
  (which-key-mode)) 


;; Shackle
(use-package shackle)


;; Disable UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode 0)


;; Disable scroll bars
(defun felipe/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))
(add-hook 'after-make-frame-functions 'felipe/disable-scroll-bars)

(provide 'core-interface)
