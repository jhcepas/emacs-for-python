;; syntax-highlight aggressively
(setq font-lock-maximum-decoration t)

;; set default font for all frames
(defun font-exists-p (font)
  "Test if FONT is available."
  (if (null (list-fonts (font-spec :family font)))
      ;; 2008-02-26 function of the new font backend (Emacs 23),
      ;; instead of `x-list-fonts'
      nil
    t))

;(if (font-exists-p "inconsolata-g")
;    (set-default-font "inconsolata-g")
;  )

;; avoid Emacs hanging for a while changing default font
(modify-frame-parameters nil '((wait-for-wm . nil)))

;; show column number
(column-number-mode t)

;; show paren, brace, and curly brace "partners" at all times
(show-paren-mode t)

;; Using cursor color to indicate some modes. If you sometimes find
;; yourself inadvertently overwriting some text because you are in
;; overwrite mode but you didn't expect so, this might prove as useful
;; to you as it is for me. It changes cursor color to indicate
;; read-only, insert and overwrite modes:
(setq hcz-set-cursor-color-color "")
(setq hcz-set-cursor-color-buffer "")
(defun hcz-set-cursor-color-according-to-mode ()
  "change cursor color according to some minor modes."
  ;;set-cursor-color is somewhat costly, so we only call it when
  ;;needed:
  (let ((color
	 (if buffer-read-only "blue"
	   (if overwrite-mode "red"
	     "SpringGreen"))))
    (unless (and
	     (string= color hcz-set-cursor-color-color)
	     (string= (buffer-name) hcz-set-cursor-color-buffer))
      (set-cursor-color (setq hcz-set-cursor-color-color color))
      (setq hcz-set-cursor-color-buffer (buffer-name)))))

(add-hook 'post-command-hook 'hcz-set-cursor-color-according-to-mode)
(add-hook 'after-make-frame-functions 'set-background)
(defun set-background(frame)
  ;; must be current for local ctheme
  (select-frame frame)
  ;; test winsystem
  (set-background-color "grey10")
  (set-foreground-color "grey85")
)

; Window takes the name of buffer
(setq frame-title-format "%b [%f]");

;;  Avoid anoying lag in syntax highlighting. 
(cond ((< emacs-major-version 22)
       (setq font-lock-support-mode 'lazy-lock-mode)
       (setq lazy-lock-defer-contextually t)
       (setq lazy-lock-defer-time 0)
       ))
(cond ((>= emacs-major-version 22)
       (setq jit-lock-contextually t)
       (setq jit-lock-context-time 0)
       ))

;(require 'color-theme-zenburn)
;(color-theme-zenburn)

(provide 'jhc-appearance)
