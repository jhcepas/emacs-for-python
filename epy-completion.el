;;; epy-completion.el --- A few common completion tricks

;; Pairing parentheses
;; All languages:
;(setq skeleton-pair t)
;(global-set-key "(" 'skeleton-pair-insert-maybe)
;(global-set-key "[" 'skeleton-pair-insert-maybe)
;(global-set-key "{" 'skeleton-pair-insert-maybe)
;(global-set-key "\"" 'skeleton-pair-insert-maybe)

;; Just python
;(add-hook 'python-mode-hook 
;          (lambda () 
;            (define-key python-mode-map "'" 'skeleton-pair-insert-maybe)))

;; Live completion with auto-complete
;; (see http://cx4a.org/software/auto-complete/)
(require 'auto-complete-config nil t)
(add-to-list 'ac-dictionary-directories (concat epy-install-dir "elpa-to-submit/auto-complete/dict/"))
;; Do What I Mean mode
(setq ac-dwim t)
(ac-config-default)

;; set also the completion for eshell
(add-hook 'eshell-mode-hook 'ac-eshell-mode-setup)
;(define-key ac-complete-mode-map "\t" 'ac-expand)
;(define-key ac-complete-mode-map "\r" 'ac-complete)
;(define-key ac-complete-mode-map "\M-n" 'ac-next)
;(define-key ac-complete-mode-map "\M-p" 'ac-previous)

;; custom keybindings to use tab, enter and up and down arrows
(setq ac-use-menu-map t)
;; Default settings
(define-key ac-menu-map "\t" 'ac-expand)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; Do not complete with RET/Enter
(define-key ac-completing-map "\r" nil)

;; I prefer to have instant suggestions
(setq ac-auto-show-menu t)
(setq ac-use-quick-help t)
(setq ac-quick-help-delay 0.5)
;; Smaller menu
(setq ac-menu-height 5)
(setq ac-sources '(ac-source-filename 
                   ac-source-words-in-buffer                   
                   ac-source-features
                   ac-source-functions 
                   ac-source-variables
                   ac-source-symbols 
                   ac-source-abbrev 
                   ac-source-dictionary
                   ac-source-words-in-same-mode-buffers
                   ))
;;A way of delaying processes of flyspell-mode disables auto
;;completion. You can avoid this problem with the following option
(ac-flyspell-workaround)

;; Disabling Yasnippet completion 
(defun epy-snips-from-table (table)
  (with-no-warnings
    (let ((hashtab (ac-yasnippet-table-hash table))
          (parent (ac-yasnippet-table-parent table))
          candidates)
      (maphash (lambda (key value)
                 (push key candidates))
               hashtab)
      (identity candidates)
      )))

(defun epy-get-all-snips ()
  (idle-require 'yasnippet) ;; FIXME: find a way to conditionally load it
  (let (candidates)
    (maphash
     (lambda (kk vv) (push (epy-snips-from-table vv) candidates)) yas/tables)
    (apply 'append candidates))
  )

;;(setq ac-ignores (concatenate 'list ac-ignores (epy-get-all-snips)))

;; ropemacs Integration with auto-completion
(defun ac-ropemacs-candidates ()
  (mapcar (lambda (completion)
      (concat ac-prefix completion))
    (rope-completions)))

(ac-define-source nropemacs
  '((candidates . ac-ropemacs-candidates)
    (symbol     . "p")))

(ac-define-source nropemacs-dot
  '((candidates . ac-ropemacs-candidates)
    (symbol     . "p")
    (prefix     . c-dot)
    (requires   . 0)))

(defun ac-nropemacs-setup ()
  (setq ac-sources (append '(ac-source-nropemacs
                             ac-source-nropemacs-dot) ac-sources)))
(defun ac-python-mode-setup ()
  (add-to-list 'ac-sources 'ac-source-yasnippet))

(add-hook 'python-mode-hook 'ac-python-mode-setup)
(add-hook 'rope-open-project-hook 'ac-nropemacs-setup)

(provide 'epy-completion)
;;; epy-completion.el ends here
