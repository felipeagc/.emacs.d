(use-package clojure-mode
  :mode (("\\.clj\\'" . clojure-mode))
  :config
  (use-package cider
    :init
    (setq nrepl-hide-special-buffers t)))


;; Key bindings
(felipe/leader-def 'normal clojure-mode-map
  "mf" 'cider-format-buffer
  "ms" '(cider-jack-in
         :which-key "start repl")
  "mr" '(cider-switch-to-repl-buffer
         :which-key "repl buffer"))

(general-def 'normal clojure-mode-map
  "K" 'cider-doc)

(provide 'layer-clojure)
