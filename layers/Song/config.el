;; This is added for Perl warning: Setting locale failed.
;; Added by Song Wang 20170601
(setenv "LC_ALL" "C")
(setenv "LANG" "C")

;; This is added for 4 spaces indent
;; Added by Song Wang 20180228
;; (setq-default indent-tabs-mode nil) 
(setq default-tab-width 4)
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode t)
(setq c-default-style "linux")

;; (global-display-line-numbers-mode t)
;;(recentf-mode t)
;;(smartparens-global-mode t)

;;======================================
;; Customized configuration for org-mode
;;======================================
(progn
  (require 'org-tempo) ;; insert structural blocks with a few keystroks
  (add-hook 'org-mode-hook #'visual-line-mode) ;; Activate visual-line-mode in org-mode buffers (word wrap)
  ;;Added by Song 20190121
  (setq org-file-apps
        '(("\\.docx\\'" . default)
        ("\\.mm\\'" . default)
        ("\\.x?html?\\'" . default)
        ;;		("\\.pdf\\'" . "/Applications/Skim.app/Contents/MacOS/Skim \"%s\"")
        ;;		("\\.pdf\\'" . "/Applications/PDF\ Expert.app/Contents/MacOS/PDF\ Expert \"%s\"")
        ("\\.pdf\\'" . default)
        (auto-mode . emacs)))
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "PROCESSING(p)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-emphasis-alist ;; 
       '(("*" (bold :foreground "red"))
        ("/" italic)
        ("_" underline)
        ;;("~" (:background "maroon" :foreground "white"))
        ("~" (:background "black" :foreground "green"))
        ;;("=" (:background "deep sky blue" :foreground "MidnightBlue"))
        ("=" (:background "black" :foreground "yellow"))
        ("+" (:strike-through t))
        ))
  ;; for archive
;;  (require 'org-archive-subtree-hierarchical)
;;  (setq org-archive-default-command 'org-archive-subtree-hierarchical)
  )
