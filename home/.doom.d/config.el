;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Daniel Blancas"
      user-mail-address "edblancas@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; The config upwards is the default when bin/doom install is executed ;;

;; https://github.com/ericdallo/dotfiles/blob/master/.doom.d/config.el
(let ((nudev-emacs-path "~/dev/nu/nudev/ides/emacs/"))
  (when (file-directory-p nudev-emacs-path)
    (add-to-list 'load-path nudev-emacs-path)
    (require 'nu nil t)
    (require 'nu-datomic-query nil t)))

;(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'auto-mode-alist '("\\.repl\\'" . clojure-mode))

(defun rg-ignoring-folders (folders)
  "ripgrep selected word in project excluding folder"
  (let ((symbol (thing-at-point 'symbol t))
        (args (mapconcat 'identity
                         (mapcar #'(lambda(folder) (concat "-g '!" folder "/*'"))
                                 folders)
                         " ")))
    (counsel-rg symbol (counsel--git-root) args)))

(setq-default evil-kill-on-visual-paste nil)

(setq
 fill-column 80
 display-line-numbers-type t

 history-length 300
 indent-tabs-mode nil
 confirm-kill-emacs nil
 mode-line-default-help-echo nil
 show-help-function nil
 evil-multiedit-smart-match-boundaries nil
 compilation-scroll-output 'first-error

 read-process-output-max (* 1024 1024)

;; projectile-project-search-path '("~/dev/dan" "~/dev/nu/")
 projectile-enable-caching nil
;; projectile-auto-discover t

 evil-split-window-below t
 evil-vsplit-window-right t

 ;counsel-rg-base-command "rg -i -M 1000 --no-heading --line-number --color never %s ."

 frame-title-format (setq icon-title-format  ;; set window title with "project"
                          '((:eval (projectile-project-name))))

 doom-font (font-spec :family "MonoLisa Nerd Font" :size 16)
 doom-unicode-font (font-spec :family "Material Design Icons")
 doom-big-font-increment 2

 doom-theme 'doom-dracula
 doom-themes-treemacs-theme "all-the-icons"
 doom-localleader-key ","

 evil-collection-setup-minibuffer t
 org-directory "~/Dropbox/org")

(after! projectile
  (add-to-list 'projectile-project-root-files-bottom-up "project.clj"))

(add-hook! 'projectile-after-switch-project-hook :append
  (treemacs-add-and-display-current-project-exclusively)
  (when (eq (treemacs-current-visibility) 'visible) (treemacs)))

(use-package! treemacs-all-the-icons
  :after treemacs)

(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-headerline-breadcrumb-enable   t
        lsp-lens-enable                    t
        lsp-signature-render-documentation nil
        lsp-idle-delay                     0.1
        lsp-ui-sideline-enable             nil
        lsp-completion-use-last-result     nil
        lsp-semantic-tokens-enable         t
        ;; if t then conflicts with company + orderless
        ;; lsp-completion-no-cache         nil
        lsp-headerline-breadcrumb-enable   nil)
  (advice-add #'lsp-rename
              :after (lambda (&rest _) (projectile-save-project-buffers)))
  (add-hook 'lsp-after-open-hook (lambda () (when (lsp-find-workspace 'rust-analyzer nil)
                                         (lsp-rust-analyzer-inlay-hints-mode)))))

(use-package! lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable  nil
        lsp-ui-peek-enable nil))

(use-package! lsp-treemacs
  :config
  (setq lsp-treemacs-error-list-current-project-only t))

(use-package! clojure-mode
  :config
  (setq clojure-indent-style 'align-arguments))

(use-package! cider
  :after clojure-mode
  :config
  (setq cider-show-error-buffer                 t   ;; to keep errors only at the REPL
        cider-font-lock-dynamically             nil
        cider-eldoc-display-for-symbol-at-point nil
        cider-prompt-for-symbol                 nil
        cider-use-xref                          nil)
  (set-lookup-handlers! '(cider-mode cider-repl-mode) nil)
  (add-hook 'cider-mode-hook (lambda () (remove-hook 'completion-at-point-functions #'cider-complete-at-point))))

(use-package! clj-refactor
  :after clojure-mode
  :config
  (set-lookup-handlers! 'clj-refactor-mode nil)
  (setq cljr-warn-on-eval nil
        cljr-magic-require-namespaces '(("s" . "schema.core")
                                        ("st" . "schema.test")
                                        ("m" . "matcher-combinators.matchers")
                                        ("pp" . "clojure.pprint"))))

(use-package! lsp-java
  :after java-mode
  :config
  (setq lsp-java-references-code-lens-enabled      t
        lsp-java-implementations-code-lens-enabled t))(use-package! paredit
  :hook ((clojure-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)))

(defun org-mode-hide-all-stars ()
  (font-lock-add-keywords
   'org-mode
   '(("^\\*+ "
      (0
       (prog1 nil
         (put-text-property (match-beginning 0) (match-end 0)
                            'face 'org-hide)))))))

(use-package! paredit
  :hook ((clojure-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)))

(use-package! org-tree-slide
  :after org-mode
  :config
  (setq +org-present-text-scale              2
        org-tree-slide-skip-outline-level    2
        org-tree-slide-slide-in-effect       t
        org-tree-slide-modeline-display      'outside
        org-tree-slide-fold-subtrees-skipped nil))

(use-package! json-mode
  :init
  (defconst json-mode-standard-file-ext '(".json" ".jsonld" ".json.base")
    "List of JSON file extensions."))

(use-package! git-gutter
              :config 
              (setq git-gutter:modified-sign "|"
                    git-gutter:added-sign "|"
                    git-gutter:deleted-sign "|")
              (global-git-gutter-mode t))

(put 'narrow-to-region 'disabled nil)

;; fix bug when paren matching flickers line height, in theme was 'ultrabold, can put :underline t
;; https://www.reddit.com/r/emacs/comments/fr9ozc/overlay_from_showparenmode_taller_than_line_height/
;; https://github.com/hlissner/emacs-doom-themes/blob/3e6f5d9ce129ac6fc0f466eb6f5518593625578f/doom-themes-base.el#L963
;; https://www.reddit.com/r/emacs/comments/f531pt/doom_wherehow_to_change_syntax_highlighting/
(custom-set-faces! 
  '(show-paren-match :weight bold :underline t)
  '(show-paren-mismatch :weight bold))

(defun insert-open-close-paren ()
  (interactive)
  (insert "()")
  (backward-char 1))

(defun reverse-transpose-sexps (arg)
    (interactive "*p")
    (transpose-sexps (- arg))
    ;; when transpose-sexps can no longer transpose, it throws an error and code
    ;; below this line won't be executed. So, we don't have to worry about side
    ;; effects of backward-sexp and forward-sexp.
    (backward-sexp (1+ arg))
    (forward-sexp 1))

;;(defun counsel-projectile-bookmark ()
;;    "Forward to `bookmark-jump' or `bookmark-set' if bookmark doesn't exist."
;;    (interactive)
;;    (require 'bookmark)
;;    (let ((projectile-bookmarks (projectile-bookmarks)))
;;      (ivy-read "Create or jump to bookmark: "
;;                projectile-bookmarks
;;                :action (lambda (x)
;;                          (cond ((and counsel-bookmark-avoid-dired
;;                                      (member x projectile-bookmarks)
;;                                      (file-directory-p (bookmark-location x)))
;;                                 (with-ivy-window
;;                                   (let ((default-directory (bookmark-location x)))
;;                                     (counsel-find-file))))
;;                                ((member x projectile-bookmarks)
;;                                 (with-ivy-window
;;                                   (bookmark-jump x)))
;;                                (t
;;                                 (bookmark-set x))))
;;                :caller 'counsel-projectile-bookmark)))
;;
;;(ivy-set-actions
;; 'counsel-projectile-bookmark
;; '(("d" bookmark-delete "delete")
;;   ("e" bookmark-rename "edit")))

(defun projectile-bookmarks ()
  (let ((bmarks (bookmark-all-names)))
    (cl-remove-if-not #'workspace-bookmark-p bmarks)))

(defun bmacs-project-root ()
  "Get the path to the root of your project.
If STRICT-P, return nil if no project was found, otherwise return
`default-directory'."
  (let (projectile-require-project-root)
    (projectile-project-root)))

(defun workspace-bookmark-p (bmark)
  (let ((bmark-path (expand-file-name (bookmark-location bmark))))
    (string-prefix-p (bmacs-project-root) bmark-path)))

;; https://github.com/djblue/portal/blob/master/doc/editors/emacs.md#xwidget-webkit-embed
;; Leverage an existing cider nrepl connection to evaluate portal.api functions
;; and map them to convenient key bindings.

;; def portal to the dev namespace to allow dereferencing via @dev/portal
(defun portal.api/open ()
  (interactive)
  (cider-nrepl-sync-request:eval
    "(do (ns dev) (def portal ((requiring-resolve 'portal.api/open))) (add-tap (requiring-resolve 'portal.api/submit)))"))

(defun portal.api/clear ()
  (interactive)
  (cider-nrepl-sync-request:eval "(portal.api/clear)"))

(defun portal.api/close ()
  (interactive)
  (cider-nrepl-sync-request:eval "(portal.api/close)"))

;; same as cider-ns-refresh
;; https://docs.cider.mx/cider/usage/misc_features.html#reloading-code
(defun edblancas/refresh-repl ()
  (interactive)
  (cider-nrepl-sync-request:eval "(do (require '[clojure.tools.namespace.repl]) (clojure.tools.namespace.repl/refresh))"))

;; see https://github.com/emacs-evil/evil-cleverparens#installation
(setq evil-move-beyond-eol t)

;; (use-package! evil-cleverparens
;;   :commands evil-cleverparens-mode
;;   :init
;;   (add-hook! 'clojure-mode-hook #'evil-cleverparens-mode)
;;   (add-hook! 'emacs-lisp-mode-hook #'evil-cleverparens-mode)
;;   (setq evil-cleverparens-complete-parens-in-yanked-region t)
;;   :config
;;   (evil-define-key '(normal visual) evil-cleverparens-mode-map
;;     "{" nil
;;     "}" nil))

(require 'evil-cleverparens-text-objects)

;; this is taken from the evil-cleverparens-mode.el
;; we require only the objects so the above file is not loaded
;; hence we cannot use the fn and we copy-pasted here
(defun evil-cp--enable-text-objects ()
  "Enables text-objects defined in evil-cleverparens."
  (define-key evil-outer-text-objects-map "f" #'evil-cp-a-form)
  (define-key evil-inner-text-objects-map "f" #'evil-cp-inner-form)
  (define-key evil-outer-text-objects-map "c" #'evil-cp-a-comment)
  (define-key evil-inner-text-objects-map "c" #'evil-cp-inner-comment)
  (define-key evil-outer-text-objects-map "d" #'evil-cp-a-defun)
  (define-key evil-inner-text-objects-map "d" #'evil-cp-inner-defun))

(evil-cp--enable-text-objects)

;; see how to blacklist minibuffer, treemacs, magit and jet transiet windows, etc.
;; (use-package! edwina
;;   :config
;;   (setq display-buffer-base-action '(display-buffer-below-selected))
;;   (edwina-setup-dwm-keys 'super)
;;   (edwina-mode 1))

;; is there a difference?
;; https://github.com/abo-abo/swiper#counsel
;;(use-package! counsel
;;  :hook ((ivy-mode . counsel-mode)))

;; fix treemacs opens in a window below
(set-popup-rule! "\\*Treemacs-Scoped.*\\*" :side 'left :width 0.2)

;; disable auto format on save for json
;; is disabled for all modes on init.el
;(add-hook! 'json-mode-hook (format-all-mode -1))

;; I like treating - and _ as part of the word
(modify-syntax-entry ?- "w" clojure-mode-syntax-table)
(modify-syntax-entry ?_ "w" clojure-mode-syntax-table)
(modify-syntax-entry ?- "w" emacs-lisp-mode-syntax-table)
(modify-syntax-entry ?_ "w" emacs-lisp-mode-syntax-table)

(load! "+bindings")
