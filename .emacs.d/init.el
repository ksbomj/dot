;; Paths & packages

(add-to-list 'load-path "~/.emacs.d/features")
(add-to-list 'load-path "~/.emacs.d/settings")
(add-to-list 'load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/elpa/exwm-0.24")
(add-to-list 'load-path "~/.emacs.d/elpa/xelb-0.18")


(load-library "workspace-window-manager")

(setq locate-command "locate")
(setq inferior-lisp-program "/usr/local/bin/ecl")
(setq elpy-rpc-python-command "python3")
(setq locate-make-command-line
      (lambda (ss) (list locate-command "/home/ksbomj" "-name" ss)))

(set-face-attribute 'default nil
                    :family "Terminus" :height 160 :weight 'normal)
(set-face-attribute 'variable-pitch nil
                    :family "Open Baskerville 0.0.75" :height 130 :weight 'normal)

(defun async-term ()
  "Open terminal"
  (interactive)
  (start-process "urxvt" "urxvt" "urxvt"))

;(find-file "~/org/index.org")