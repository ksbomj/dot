(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Code completetion
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(defun srm/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode .  srm/lsp-mode-setup)
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

;; Package required by go-lsp
(use-package smartparens)

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
