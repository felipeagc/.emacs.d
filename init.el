(add-to-list 'load-path (concat user-emacs-directory "core/"))
(add-to-list 'load-path (concat user-emacs-directory "layers/"))

(setq vc-follow-symlinks t)

(require 'core)

;; Layers
(require 'layer-buffers)
(require 'layer-ivy)
(require 'layer-projectile)
(require 'layer-git)
(require 'layer-snippets)
(require 'layer-flycheck)
(require 'layer-company)
(require 'layer-lsp)
(require 'layer-dap)
(require 'layer-org)
(require 'layer-dumb-jump)
(require 'layer-editorconfig)
(require 'layer-zeal)
(require 'layer-writeroom)
(require 'layer-restart)
(require 'layer-quickrun)

;; Languages
(require 'layer-c-c++)
(require 'layer-clojure)
(require 'layer-elisp)
(require 'layer-glsl)
(require 'layer-go)
(require 'layer-haskell)
(require 'layer-js)
(require 'layer-lua)
(require 'layer-python)
(require 'layer-rust)
(require 'layer-web)
(require 'layer-yaml)
(require 'layer-zig)
(require 'layer-java)
(require 'layer-julia)

