;;; packages.el --- Song layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2021 Sylvain Benner & Contributors
;;
;; Author: wangsong <wangsong@Songs-MacBook-Pro.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `Song-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `Song/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `Song/pre-init-PACKAGE' and/or
;;   `Song/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:


(defconst Song-packages
  '(
	org       ;; set up the customized configuration for org
	;; zotxt     ;; for connection to the Zotero server
	;; (zotxt-emacs :location local)
	(zotxt-emacs :location (recipe :fetcher local))
	(org-roam :location (recipe :fetcher local))
	;; auctex
	cdlatex   ;; fast input methods for LaTeX environments and math
	org-fragtog
	org-download
	;; smartparens
	;; (page-break-lines :excluded t)

	;; (org-roam-ui :location (recipe :fetcher local :file ("*.el" "out")))
	;; (org-roam-ui :location (recipe
	;; 							:fetcher github
	;; 							:repo "org-roam/org-roam-ui"
	;; 							:branch "main"
	;; 							:files ("*.el" "out") ))
	websocket
    )
  "The list of Lisp packages required by the Song layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun Song/init-zotxt-emacs ()
;; (defun Song/init-zotxt ()
  (use-package zotxt
	:bind (("C-c \" i" . org-zotxt-insert-reference-link)
		   ("C-c \" a" . org-zotxt-open-attachment)
	       ("C-c \" o" . org-zotxt-search-open-attachment))
	:hook (org-mode . org-zotxt-mode) ;; Activate org-zotxt-mode in org-mode buffers
    :init
    :config
    (progn
      ;; Change citation format to be less cumbersome in files.
      ;; You'll need to install mkbehr-short into your Zotero style manager first.
      (eval-after-load "zotxt"
        '(setq zotxt-default-bibliography-style "mkbehr-short")))))
;; (defun Song/init-smartparens ()
;;   (use-package smartparens
;; 	:config
;;     (smartparens-global-mode t)))

(defun Song/post-init-org ()
  (use-package org
	:defer nil
	:init
	:config
	(plist-put org-format-latex-options :scale 1.5)
	))

;; (defun Song/init-auctex ()
;;   (use-package auctex
;; 	);;cdlatex
;; 	)

(defun Song/init-cdlatex ()
  (use-package cdlatex
	:hook (org-mode . turn-on-org-cdlatex)
	);;cdlatex
  )

(defun Song/init-org-fragtog ()
  (use-package org-fragtog
	:hook (org-mode . org-fragtog-mode)
	))

(defun Song/post-init-org-download ()
  (use-package org-download
    :commands (org-download-clipboard)
    :init
    (progn
	  (add-hook 'org-mode-hook 'org-download-enable)
	  (add-hook 'org-mode-hook (lambda () (local-set-key (kbd "C-c i c") #'org-download-clipboard)))
	  (add-hook 'org-mode-hook (lambda () (local-set-key (kbd "C-c i s") #'org-download-screenshot)))
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "iDc" 'org-download-clipboard))))

(defun Song/post-init-org-roam ()
  (use-package org-roam
	:init
	(setq org-roam-v2-ack t)
	:custom
	(org-roam-directory "~/Dropbox/org/orgroam/")
	(org-roam-completion-everywhere t)
	:bind (("C-c n l" . org-roam-buffer-toggle)
           ("C-c n f" . org-roam-node-find)
           ("C-c n g" . org-roam-graph)
           ("C-c n i" . org-roam-node-insert)
           ("C-c n c" . org-roam-capture)
		   ("C-c n b" . org-roam-buffer)
           ;; Dailies
           ("C-c n j" . org-roam-dailies-capture-today)
		   :map org-mode-map
		   ("C-M-i"   . completion-at-point))
	:config
    (org-roam-db-autosync-mode)
	;; If using org-roam-protocol
    (require 'org-roam-protocol)))

;; (defun Song/init-org-roam-ui ()
;;   (use-package org-roam-ui
;; 	:after org-roam
;; 	:config
;; 	(setq org-roam-ui-sync-theme t
;;           org-roam-ui-follow t
;;           org-roam-ui-update-on-save t
;;           org-roam-ui-open-on-start t)
;; 	))

(defun Song/init-websocket ()
  (use-package websocket
	:after org-roam)
  )
