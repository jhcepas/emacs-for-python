;; Open special buffers in new window
(setq special-display-buffer-names
      ;'("*Completions*" )
      )
;; swap 2 windows
(defun swap-buffers ()
  "Put the buffer from the selected window in next window, and vice versa"
  (interactive)
  (let* ((this (selected-window))
     (other (next-window))
     (this-buffer (window-buffer this))
     (other-buffer (window-buffer other)))
    (set-window-buffer other this-buffer)
    (set-window-buffer this other-buffer)
    )
  )
(global-set-key (kbd "<f12>") 'swap-buffers)

;; operate on buffers like Dired
;; completely replaces `list-buffer'
(defalias 'ibuffer-list-buffers 'list-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-saved-filter-groups
      '(("default"
         ("VERSION CONTROL" (or (mode . svn-status-mode)
                                (mode . svn-log-edit-mode)
                                    (name . "^\\*svn-")
                                    (name . "^\\*vc\\*$")
                                    (name . "^\\*Annotate")
                                    (name . "^\\*git-")
                                    (name . "^\\*vc-")))
         ("- Python -" (or (mode . python-mode)
                           ))
         ("web" (or (mode . html-mode)
                    (mode . js-mode)
                    (mode . css-mode)
                      ))
         ("C" (or (mode . c-mode)
                   ))
         ("TXT" (or (mode . text-mode)
                      ))
          ("emacs" (or (name . "^\\*scratch\\*$")
                       (name . "^\\*Messages\\*$")
                       (name . "^TAGS\\(<[0-9]+>\\)?$")
                       (name . "^\\*Help\\*$")
                       (name . "^\\*info\\*$")
                       (name . "^\\*Occur\\*$")
                       (name . "^\\*grep\\*$")
                       (name . "^\\*Compile-Log\\*$")
                       (name . "^\\*Backtrace\\*$")
                       (name . "^\\*Process List\\*$")
                       (name . "^\\*gud\\*$")
                       (name . "^\\*Kill Ring\\*$")
                       (name . "^\\*Completions\\*$")
                       (name . "^\\*tramp")
                       (name . "^\\*shell\\*$")
                       (name . "^\\*compilation\\*$")))
          ("Lisp" (or (mode . emacs-lisp-mode)
                              ))
          ("agenda" (or (name . "^\\*Calendar\\*$")
                        (name . "^diary$")
                        (name . "^\\*Agenda")
                        (name . "^\\*org-")
                        (name . "^\\*Org")
                        (mode . org-mode)
                        (mode . muse-mode)))
          ("latex" (or (mode . latex-mode)
                       (mode . LaTeX-mode)
                       (mode . bibtex-mode)
                       (mode . reftex-mode)))
          ("Files" (or (mode . dired-mode))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Order the groups so the order is : [Default], [agenda], [emacs]
(defadvice ibuffer-generate-filter-groups (after reverse-ibuffer-groups ()
                                                 activate)
  (setq ad-return-value (nreverse ad-return-value)))

(provide 'jhc-buffers)
