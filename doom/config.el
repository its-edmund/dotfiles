;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/dev/notes-org-roam")
(setq org-agenda-files
      (directory-files-recursively
        org-directory
        "\\.org$"
        :include-hidden t))

(setq org-todo-keywords '((sequence "TODO(t)" "DOING(p)" "|" "DONE(d)")))

(require 'org)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun dw/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(use-package org
             :hook (org-mode . dw/org-mode-setup)
             :config
             (setq org-ellipsis " ▾"
                   org-hide-emphasis-markers t))

(use-package org-bullets
             :after org
             :hook (org-mode . org-bullets-mode)
             :custom
             (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Replace list hyphen with dot
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

;; Make sure org-indent face is available
(require 'org-indent)

(use-package org-roam
             :ensure t
             :custom
             (org-roam-directory (file-truename org-directory))
             :bind (("C-c n l" . org-roam-buffer-toggle)
                    ("C-c n f" . org-roam-node-find)
                    ("C-c n g" . org-roam-graph)
                    ("C-c n i" . org-roam-node-insert)
                    ("C-c a" . org-agenda)
                    :map org-mode-map
                    ("C-M-i" . completion-at-point)
                    :map org-roam-dailies-map
                    ("Y" . org-roam-dailies-capture-yesterday)
                    ("T" . org-roam-dailies-capture-tomorrow))
             :bind-keymap
             ("C-c n d" . org-roam-dailies-map)
             :config
             (require 'org-roam-dailies)
             ;; If you're using a vertical completion framework, you might want a more informative completion interface
             (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
             (org-roam-db-autosync-mode)
             ;; If using org-roam-protocol
             (require 'org-roam-protocol))

(defun my/refresh-org-agenda-files ()
  "Update `org-agenda-files' to include all Org files recursively."
  (interactive)
  (setq org-agenda-files
        (directory-files-recursively
          org-directory
          "\\.org$"
          :include-hidden t)))

;; Refresh files before agenda opens
(advice-add 'org-agenda :before #'my/refresh-org-agenda-files)

(use-package! websocket
              :after org-roam)

(use-package! org-roam-ui
              :after org-roam ;; or :after org
              ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
              ;;         a hookable mode anymore, you're advised to pick something yourself
              ;;         if you don't care about startup time, use
              ;;  :hook (after-init . org-roam-ui-mode)
              :config
              (setq org-roam-ui-sync-theme t
                    org-roam-ui-follow t
                    org-roam-ui-update-on-save t
                    org-roam-ui-open-on-start t))

(defun my/org-roam-get-recursive-child-count (node-id)
  "Recursively count the number of child nodes for a given NODE-ID."
  (let* ((query "WITH RECURSIVE children AS (
                                             SELECT id, ref FROM nodes WHERE id = ?
                                             UNION ALL
                                             SELECT nodes.id, nodes.ref FROM nodes
                                             INNER JOIN links ON nodes.id = links.dest
                                             INNER JOIN children ON links.source = children.id
                                             )
                SELECT COUNT(*) FROM children;")
                (count (caar (org-roam-db-query query node-id))))
         (or count 0))) ;; Default to 0 if nil

(setq org-roam-ui-custom-node-size-function
      (lambda (node)
        (let ((size (my/org-roam-get-recursive-child-count (org-roam-node-id node))))
          (max 5 (* 2 size))))) ;; Prevents tiny nodes
