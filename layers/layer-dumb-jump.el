(use-package dumb-jump
  :config
  (dumb-jump-mode))


;; Key bindings
(general-def 'normal
  "gd" 'dumb-jump-go
  "gD" 'dumb-jump-go-other-window)

(provide 'layer-dumb-jump)
