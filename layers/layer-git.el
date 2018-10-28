;; Magit
(use-package magit)

(use-package evil-magit
  :after magit)


;; Git gutter
(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode +1)

  (setq-default fringes-outside-margins t)
  ;; thin fringe bitmaps
  (fringe-helper-define 'git-gutter-fr:added '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:deleted 'bottom
    "X......."
    "XX......"
    "XXX....."
    "XXXX...."))


;; Key bindings
(felipe/leader-def
  :keymaps 'normal
  "gg" 'magit-status)

(provide 'layer-git)
