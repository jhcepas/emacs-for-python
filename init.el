;; Add my personal directory to the path 
(setq load-path (cons "~/.emacs.d/" load-path))

;; Trick to get the filename of the installation directory
(defconst epy-install-dir
  (file-name-directory (or load-file-name
                           (when (boundp 'bytecomp-filename) bytecomp-filename)
                           buffer-file-name))
  "Installation directory of emacs-for-python"
)
(add-to-list 'load-path epy-install-dir)

(require 'epy-setup)
(require 'epy-python)
(require 'epy-completion)
(require 'epy-editing)
(require 'epy-bindings)

(require 'jhc-backups)
(require 'jhc-navigation)
(require 'jhc-buffers)
(require 'jhc-spellcheck)
(require 'jhc-appearance)
(require 'jhc-orgmode)

(require 'template)
(template-initialize)

;(require 'pdb)

(setq auto-mode-alist
      (append '(
                ("\\.css\\'"                           . css-mode)
                ("\\.\\(htm\\|html\\|xhtml\\)$"        . html-mode)
                ("\\.sql$"                             . sql-mode)
                ("\\.js$"                              . js-mode)
                ("\\.json$"                            . js-mode)
                ("\\.js$"                              . js-mode)
                ("\\.py"                               . python-mode)
                ;; sorted by chapter
                ("\\.\\(diffs?\\|patch\\|rej\\)\\'"    . diff-mode)
                ("\\.txt$"                             . org-mode)
                ("\\.dat$"                             . ledger-mode)

                ("\\.log$"                             . text-mode)
                ("\\.tex$"                             . LaTeX-mode)
                ("\\.tpl$"                             . LaTeX-mode)
                ("\\.cgi$"                             . perl-mode)
                ("[mM]akefile"                         . makefile-mode)
                ("\\.bash$"                            . shell-script-mode)
                ("\\.expect$"                          . tcl-mode)

                (".ssh/config\\'"                      . ssh-config-mode)
                ("sshd?_config\\'"                     . ssh-config-mode)
                ) auto-mode-alist))


;; Perl based replace function
(defun perl-replace (start end)
  "Replace a text pattern in a  region using perl expressions"
  (interactive "*r")
  (setq regexp (read-string "Regexp: "))
  (setq to-string (read-string (concat "[" regexp "] Replacement: ")))
  (setq command (concat "perl -e 's/" regexp "/" to-string "/g' -p"))
  (print command)
  (shell-command-on-region start end command nil 1)
  )
(global-set-key "\M-r" 'perl-replace)

;; Fullscreen emacs
(defun switch-full-screen ()
      (interactive)
      (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))
;(global-set-key [f11] 'switch-full-screen)

; My references database
(setq reftex-default-bibliography   (quote       ("~/refs.bib")))       

;; ;;;;;;;;;;;; TRAMP
(setq tramp-default-method "scp")
(setq tramp-default-user "jhuerta")
(setq tramp-auto-save-directory "/tmp/")
;; "turn off" the effect of `backup-directory-alist' for TRAMP files
(add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp nil))


;;  COMPLETION

;; ;; list of expansion functions tried (in order) by `hippie-expand'
;; (setq hippie-expand-try-functions-list
;;       '(try-expand-dabbrev   ; from current buffer
;;         try-expand-dabbrev-visible   ; from visible parts of all windows
;;         try-expand-dabbrev-all-buffers   ; from all other buffers
;;         try-expand-dabbrev-from-kill
;;         try-complete-file-name-partially
;;         try-complete-file-name
;;         try-expand-all-abbrevs
;;         try-expand-list
;;         try-expand-line
;;         try-complete-lisp-symbol-partially
;;         try-complete-lisp-symbol
;;         try-expand-whole-kill))

;; ;; expand-function
;; (defun my-hippie-expand (arg)
;;   ;; called with a positive prefix `P', it jumps directly to the `P'-th
;;   ;; `try-function'
;;   (interactive "P")
;;   ;; `hippie-expand' does not have a customization-feature (like
;;   ;; `dabbrev-expand') to search case-sensitive for completions. So we
;;   ;; must set `case-fold-search' temporarily to nil!
;;   (let ((old-case-fold-search case-fold-search))
;;     (setq case-fold-search nil)
;;     (hippie-expand arg)
;;     (setq case-fold-search old-case-fold-search)))

;; (global-set-key [(S-iso-lefttab)] 'my-hippie-expand)
;; (global-set-key [(backtab)] 'my-hippie-expand)
;; ;(global-set-key [(control tab)] 'my-hippie-expand)

;; ; Shift-TAB does not work in terminal mode. In my case, backtab is recognized instead
;; (global-set-key [backtab] 'my-hippie-expand)



(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(inverse-video nil)
 '(line-number-display-limit nil)
 '(menu-bar-mode nil)
 '(show-paren-mode t nil (paren))
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(truncate-partial-width-windows t)
 '(use-file-dialog nil)
 '(visible-bell t)
 '(x-select-enable-clipboard t)
 '(x-stretch-cursor nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "grey10" :foreground "grey85" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(flymake-errline ((((class color)) (:underline "dark red" :slant italic))))
 '(flymake-warnline ((((class color)) (:underline "grey52"))))
 '(flyspell-duplicate ((t (:underline t :slant italic))))
 '(flyspell-incorrect ((t (:underline t :weight bold))))
 '(font-lock-comment-face ((t (:foreground "indianred"))))
 '(font-lock-keyword-face ((t (:foreground "turquoise3"))))
 '(font-lock-string-face ((t (:foreground "palegreen4"))))
 '(outline-2 ((t (:foreground "steelblue1"))))
 '(rst-level-1-face ((t (:background "darkred"))) t)
 '(rst-level-2-face ((t (:foreground "indianred"))) t)
 '(rst-level-3-face ((t (:background "grey30" :foreground "lightblue"))) t)
 '(rst-level-4-face ((t (:background "grey20"))) t))
