;; Font Configuration ----------------------------------------------------------

;;(set-face-attribute 'default nil :font "Fira Code Retina" :height runemacs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 260)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 295 :weight 'regular)

(use-package smart-mode-line)

(setq sml/mode-width 'full)
(setq sml/name-width 20)
(setq sml/shorten-modes 't)
(setq sml/no-confirm-load-theme t)

(sml/setup)

(fringe-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

(sml/apply-theme 'respectful)

(set-face-attribute 'default nil
                    :family "Terminus" :height 160 :weight 'normal)

(set-face-attribute 'variable-pitch nil
                    :family "Open Baskerville 0.0.75" :height 130 :weight 'normal)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package all-the-icons)
