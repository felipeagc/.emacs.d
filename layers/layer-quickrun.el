(use-package quickrun
  :init
  (setq quickrun-focus-p nil))


;; Key bindings
(felipe/leader-def
  :keymaps 'normal
  "mq" 'quickrun)


(provide 'layer-quickrun)
