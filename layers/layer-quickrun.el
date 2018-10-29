(use-package quickrun
  :init
  (setq quickrun-focus-p nil))


;; Key bindings
(felipe/leader-def
  :keymaps 'normal
  "mR" 'quickrun)


(provide 'layer-quickrun)
