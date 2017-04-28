;; ============= ;;
;; Configuration ;;
;; ============= ;;

;; Expected plugins:
;; - Magit
;; - Ack
;; - Company

;; Razmans fantastic library
(load "~/.emacs.d/razman")

;; Keep 'customize' stuff in a different file
(setq custom-file "~/.emacs.d/custom.el")
(if (not (file-exists-p custom-file)) ; Only happens on the first startup
    (with-temp-buffer (write-file custom-file)))

(load "~/.emacs.d/custom.el")

;; Add Melpa repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; Sökningar är "case sensitive"
(setq-default case-fold-search nil)

;; Visa rad i statusfältet
(line-number-mode 1)
(setq column-number-mode t)

;; Just creates stale lockfiles. Unnessecary on a single user system...
(setq create-lockfiles nil)

;; I save all the time anyway.
(setq-default auto-save-mode nil)

;; Inga tabbar!
(setq-default indent-tabs-mode nil)

;; Från emacswiki.org - bli av med alla ~backupfiler
(setq
   backup-by-copying t
   backup-directory-alist
   '(("." . "~/.emacs.d/saves"))
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)

;; Scrolla Buffern Under Kompilering
(setq compilation-scroll-output 'first-error)
(add-to-list 'compilation-search-path "/home/rasmat/tacks/apsw/")
; (setq compilation-search-path ("/home/rasmat/tracks/apsw/" nil))

;; Remove trailing whitespaces when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; All files are visited read-only
(add-hook 'find-file-hook 'read-only-mode)

;; Use company in all buffers (test)
(add-hook 'after-init-hook 'global-company-mode)

;; C and C++ modes
(setq c-tab-always-indent t)
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(setq gdb-many-windows t)
(add-hook 'c-mode-common-hook
          (lambda()
            (progn
              (local-set-key "\C-ca" 'ff-find-other-file)
              (local-set-key "\C-cc" 'comment-or-uncomment-region-or-line)
              (local-set-key "\C-cf" 'clang-format-buffer)
              (local-set-key "\C-ch" 'raz-insert-cpp-heading))))

;; C
(add-hook 'c-mode-hook
          (lambda()
            (progn
              (setq comment-start "// ")
              (setq comment-end ""))))

;; Org-mode
(setq-default org-time-clocksum-format
              '(:hours "%d timmar och " :require-hours t :minutes "%02d minuter" :require-minutes t))

;; Global unmappings with comments
(global-unset-key (kbd "C-t")) ; Useless but first and foremost, it gets in the way for C-y
(global-unset-key (kbd "C-x C-d")) ; Almost useless and gets in the way for C-x d
(global-unset-key (kbd "C-x" C-r)) ; All buffers are opened read only. Better used for reverting.

;; Global remappings
(global-set-key "\C-x\C-b" 'raz-buffer-menu-with-prefix-arg)
(global-set-key "\C-x4\C-b" ' raz-buffer-menu-with-prefix-arg-other-window)
(global-set-key (kbd "<f9>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f8>") 'raz-toggle-eshell-in-current-window)
(global-set-key (kbd "<f12>") 'raz-toggle-init-file-in-current-window)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-a") 'raz-ack-in-project-root)
(global-set-key (kbd "<backtab>") 'company-complete)
(global-set-key (kbd "C-x C-r") 'revert-buffer)

(require 'dired)
(define-key dired-mode-map (kbd "<mouse-2>") 'dired-find-file)
(define-key dired-mode-map (kbd "<mouse-1>") 'dired-find-file)

(setq org-agenda-files '("/home/rasmat/Org/"))
