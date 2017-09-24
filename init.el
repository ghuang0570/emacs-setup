
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/packages/")
(load "~/.emacs.d/init-packages.el")

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-face-attribute 'default nil :height 130)

;; setup for tmux
(setq x-select-enable-clipboard t
      x-select-enable-primary t)

;;https://stackoverflow.com/questions/10171280/how-to-launch-gui-emacs-from-command-line-in-osx
;;(x-focus-frame nil)
(load-theme 'misterioso)

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("4ec8b6176354c43680d02594ce99e98134a6feb5d3537f7f68b9ee40020c214e" default)))
 '(delete-auto-save-files t)
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (python-mode autofit-frame json-mode ## go-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; make backup to a designated dir, mirroring the full path
(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* (
	(backupRootDir "~/.emacs.d/emacs-backup/")
	(filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath ))
					;remove Windows driver letter in path, for example, “C:”
	(backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") ))
	)
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath
  )
)
(setq make-backup-file-name-function 'my-backup-file-name)

;; Coding mode
(defun add-to-mode (mode lst)
  (dolist (file lst)
    (add-to-list 'auto-mode-alist
		 (cons file mode))))
;;YAML
(require 'yaml-mode)
(add-to-mode 'yaml-mode (list
			 "\\.yml$"
			 "\\.yaml$"))
(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
;;JSON
(require 'json-mode)
(add-to-mode 'json-mode (list "\\.json5$"))
;;RUBY
(require 'ruby-mode)
(add-to-mode 'ruby-mode (list
			 "\\.rake$"
			 "\\.gemspec$"
			 "\\.ru$"
			 "Rakefile$"
			 "Gemfile$"
			 "Capfile$"
			 "Vagrantfile$"))

;;;; ************************************************************************
;;;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)


;;; NeoTree hooks
;;; https://www.emacswiki.org/emacs/NeoTree
(add-to-list 'load-path "~/bin/neotree/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(setq neo-modern-sidebar t)
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)
(setq neo-window-width 30)
(setq neo-persist-show nil)
;;;(add-hook 'after-init-hook #'neotree-toggle) ;;Start NeoTree upon emacs start


(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 100)) ;;Added 30 for neotree window

(setq ag-reuse-window 't)

(add-to-list 'package-archives
'("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(add-hook 'before-save-hook 'gofmt-before-save)
(setq indent-tabs-mode nil)

(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))
(setq mouse-sel-mode t)

(require 'autofit-frame)
(add-hook 'after-make-frame-functions 'fit-frame)

;; Load additional setup
(load "~/.emacs.d/packages/custom-window-resize.el")
(load "~/.emacs.d/packages/airbnb-setup.el")
