(idle-require 'ispell)
;; (setq-default ispell-program-name
;;               (if (file-executable-p "/usr/bin/hunspell")
;;                   "/usr/bin/hunspell"
;;                 "/usr/bin/aspell"))
(setq-default ispell-program-name "/usr/bin/aspell")

;; Default dict is british english
(ispell-change-dictionary "british")

;; ask to search dictionary
(global-set-key (kbd "<f7>") 'switch-to-spanish-and-check)

;; Check buffer with the loaded dictionary (default:english)
(global-set-key (kbd "<f8>") 'flyspell-buffer)

;; Change to spanish and check buffer
(global-set-key (kbd "<C-f8>") 'ispell-change-dictionary)
(defun switch-to-spanish-and-check ()
  (interactive)
  (ispell-change-dictionary "castellano")
  (flyspell-buffer)
  (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checking" t)
  )

;;; Check all my texts 
(add-hook 'text-mode-hook       'flyspell-mode)

;; check comments and strings in all programming modes
(add-hook 'autoconf-mode-hook   'flyspell-prog-mode)
(add-hook 'autotest-mode-hook   'flyspell-prog-mode)
(add-hook 'c++-mode-hook        'flyspell-prog-mode)
(add-hook 'c-mode-hook          'flyspell-prog-mode)
(add-hook 'cperl-mode-hook      'flyspell-prog-mode)
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode)
(add-hook 'makefile-mode-hook   'flyspell-prog-mode)
(add-hook 'nxml-mode-hook       'flyspell-prog-mode)
(add-hook 'python-mode-hook     'flyspell-prog-mode)
(add-hook 'sh-mode-hook         'flyspell-prog-mode)

;; set on the fly spell checking 
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checking" t)

;; don't consider that a word repeated twice is an error
(setq flyspell-mark-duplications-flag nil)

;; enable the likeness criteria
(setq flyspell-sort-corrections nil)

;; don't use `M-TAB' to correct word (only use `C-.')
(setq flyspell-use-meta-tab nil)

;; `flyspell-auto-correct-word' is bound to `C-.'
;; Press it one time to correct the word under the cursor.
;; If several spellings are possible, they appear in the minibuffer. Just
;; keep hitting `C-.' to replace the word with the successive suggestions.

;; dash character (`-') is considered as a word delimiter
(setq flyspell-consider-dash-as-word-delimiter-flag t)

;; don't print messages for every word (when checking the entire buffer)
;; as it causes an enormous slowdown
(setq flyspell-issue-message-flag nil)

(provide 'jhc-spellcheck)
