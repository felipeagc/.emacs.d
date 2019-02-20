(use-package lsp-java
  :after lsp
  :config
  (add-hook 'java-mode-hook 'lsp))

(felipe/leader-def 'normal java-mode-map
  "mu" 'lsp-java-update-project-configuration
  "md" 'lsp-ui-doc-show
  "mr" 'lsp-rename)

(general-def 'normal java-mode-map
  "gd" 'lsp-ui-peek-find-definitions)

(provide 'layer-java)
