(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

;; Go
(use-package go-mode
  :init
  :bind
  (:map go-mode-map
        ("C-c e g" . godoc))
  :hook ((go-mode . lsp)
         (go-mode . smartparens-mode)))

(use-package go-guru
  :after go-mode)


(eval-after-load 'speedbar
  '(speedbar-add-supported-extension ".go"))
