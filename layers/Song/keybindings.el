;; Added by Song 20190508
;; Downloaded from https://gist.github.com/railwaycat/3498096
;; Keybonds
(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper w)]
                '(lambda () (interactive) (delete-frame)))
(global-set-key [(hyper z)] 'undo)
(global-set-key [(hyper \{)] '(lambda ()(interactive)(other-frame 1)))
(global-set-key [(hyper \})] '(lambda ()(interactive)(other-frame -1)))


;; set org-agenda shotcut
(global-set-key (kbd "C-c a") 'org-agenda)

(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(global-unset-key (kbd "C-M-SPC"))


;; Added by Song 20190508
;; Set the left =option= to meta and right =option= untouched.
;; command to hyper
;; This is for the homebrew emacsmacport, for emacs 26.2
(setq-default mac-option-modifier 'meta)
(setq-default mac-command-modifier 'hyper)
(setq-default mac-right-option-modifier nil)


;; org-roam related


;;(provide 'init-keybindings)
