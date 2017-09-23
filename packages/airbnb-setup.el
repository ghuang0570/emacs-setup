;;;; ************************************************************************
;;;; For Airbnb Setup

;;;; 1) Whitespace trim
;;;; ************************************************************************
;;;; *** strip trailing whitespace on write
;;;; ************************************************************************
;;;; ------------------------------------------------------------------------
;;;; --- ws-trim.el - [1.3] ftp://ftp.lysator.liu.se/pub/emacs/ws-trim.el
;;;; ------------------------------------------------------------------------
(load "~/.emacs.d/packages/ws-trim")
(require 'ws-trim)
(global-ws-trim-mode t)
(set-default 'ws-trim-level 2)
(setq ws-trim-global-modes '(guess (not message-mode eshell-mode)))
(add-hook 'ws-trim-method-hook 'joc-no-tabs-in-java-hook)

(defun remove-trailing-space-in-hook ()
  "WS-TRIM Hook to strip all tabs in Java/Ruby mode only"
  (interactive)
  (if (or (string= major-mode "jde-mode")
	  (string= major-mode "ruby-mode"))
      (ws-trim-tabs)))

;;;; Line length limit
(require 'whitespace)
(setq whitespace-line-column 100) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)

;;; Browse code at remote
(global-set-key (kbd "C-c g g") 'browse-at-remote/browse)
