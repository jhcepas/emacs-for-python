;; fights murphys law
(setq undo-outer-limit 10000000)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Nice shell within emacs :)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; If emacs 22 or higher. Use CUA mode. I love the rectangle mode
(cond ((>= emacs-major-version 22)
       (if (display-graphic-p)
           (progn
             (cua-mode t))
         ;;(pc-selection-mode)
         )
       ))
;; If emacs 21, use pc-selection mode
(cond ((< emacs-major-version 22)
       (pc-selection-mode) 
       ))

;; don't automatically add new lines when scrolling down at the bottom
;; of a buffer
(setq next-line-add-newlines nil)

;; When you scroll down with the cursor, emacs will move down the buffer one 
;; line at a time, instead of in larger amounts.
(setq scroll-step 1)

;; make the ENTER key indent next line properly
(local-set-key "\C-m" 'newline-and-indent)

;; Set M-g to goto-line
(global-unset-key "\M-g")
(global-set-key "\M-g" 'goto-line)


;; Make sure that emacs behave a little bit like xemacs
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

;; Set C-home and C-end as in xemacs
(global-set-key [(control home)] 'beginning-of-buffer)
(global-set-key [(control end)] 'end-of-buffer)

;; Don't automatically add new lines when scrolling down at the bottom
;; of a buffer
(setq next-line-add-newlines nil)

;; Change pasting behavior. Normally, it pastes where the mouse is at,
;; which is not necessarily where the cursor is. This changes things
;; so all pastes, whether they be middle-click or C-y or menu, all
;; paste at the cursor. Very useful for me.
(setq mouse-yank-at-point t) 

;; Code folding 
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(add-hook 'python-mode-hook     'hs-minor-mode)

(global-set-key (kbd "<C-S-down>") 'hs-show-all)
(global-set-key (kbd "<C-S-up>") 'hs-hide-all)
(global-set-key (kbd "<C-S-right>") 'hs-toggle-hiding)

;; Enables mousewheel to scroll window under mouse up and down by five
;; lines
(defun sd-mousewheel-scroll-up (event)
  (interactive "e")
  (let ((current-window (selected-window)))
    (unwind-protect
        (progn 
          (select-window (posn-window (event-start event)))
          (scroll-up 5))
      (select-window current-window))))
(defun sd-mousewheel-scroll-down (event)
  (interactive "e")
  (let ((current-window (selected-window)))
    (unwind-protect
        (progn 
          (select-window (posn-window (event-start event)))
          (scroll-down 5))
      (select-window current-window))))
(global-set-key (kbd "<mouse-5>") 'sd-mousewheel-scroll-up)
(global-set-key (kbd "<mouse-4>") 'sd-mousewheel-scroll-down)

;; Keeps the cursor in the same relative row during
;; pgups and dwns.
(setq scroll-preserve-screen-position t)

(provide 'jhc-navigation)
