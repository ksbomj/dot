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

;; Flycheck
(use-package flycheck
  :diminish flycheck-mode
  :custom
  (flycheck-php-executable "/usr/local/bin/php"))

;; Go
(use-package go-mode
  :init
  :bind
  (:map go-mode-map
        ("C-c e g" . godoc))
  :hook ((go-mode . lsp)
         (go-mode . smartparens-mode)))

(add-hook 'before-save-hook #'gofmt-before-save)

(use-package go-guru
  :after go-mode)

(eval-after-load 'speedbar
  '(speedbar-add-supported-extension ".go"))


;; before install go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.43.0
(use-package flycheck-golangci-lint
  :ensure t
  :hook (go-mode . flycheck-golangci-lint-setup))

;; PHP
(defvar srm/phpcbf-executable "~/.php/phpcbf.phar")
(defvar srm/php-style "PSR12")
(defvar srm/phpcs-executable "~/.php/phpcs.phar")

(use-package php-mode
  :defer t)

(use-package company-php
  :defer
  :after company)

(add-hook 'php-mode-hook '(lambda ()
			    (ac-php-core-eldoc-setup)
			    (set (make-local-variable 'company-backends)
				 '(company-ac-php-backend company-capf company-dabbrev-code
							  company-files))))

(use-package flycheck
  :ensure t
  :config
  (setq flycheck-php-phpcs-executable srm/phpcs-executable
	flycheck-phpcs-standard	srm/php-style))


(use-package web-mode
  :commands web-mode
  :mode (("\\.html\\'" . web-mode)
	 ("\\.blade.php\\'" . web-mode)))



;; Elm setup
(use-package elm-mode)
  ;; :config
  ;;(elm-format-on-save t)
  ;;(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
  ;;(add-to-list 'company-backends 'company-elm))

(use-package flycheck-elm
  :ensure t
  :after (flycheck)
  :config (add-hook 'flycheck-mode-hook #'flycheck-elm-setup))
