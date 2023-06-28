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
 display-line-numbers-type nil

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

 frame-title-format (setq icon-title-format  ;; set window title with "project"
                          '((:eval (projectile-project-name))))

 doom-font (font-spec :family "MonoLisa Nerd Font" :size 16)
 doom-unicode-font (font-spec :family "Material Design Icons")
 doom-big-font-increment 2

 doom-theme 'catppuccin
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
  (setq lsp-headerline-breadcrumb-enable   nil
        ;; conflicts with current emacs lsp-mode
        lsp-lens-enable                    nil
        lsp-signature-render-documentation nil
        lsp-idle-delay                     0.1
        lsp-ui-sideline-enable             nil
        lsp-completion-use-last-result     nil
        lsp-semantic-tokens-enable         t)
  (advice-add #'lsp-rename
              :after (lambda (&rest _) (projectile-save-project-buffers)))
  (add-hook 'lsp-after-open-hook (lambda () (when (lsp-find-workspace 'rust-analyzer nil)
                                         (lsp-rust-analyzer-inlay-hints-mode)))))

(use-package! lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable  nil
        ;; https://github.com/emacs-lsp/lsp-ui/issues/338
        lsp-ui-peek-always-show t))

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

;; disable live-preview
;; https://github.com/minad/consult#live-previews
(use-package! consult
  :config
  (consult-customize
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file))

;; --- Project Bookmars --- ;;
;; fn modified from the consult.el
;; https://github.com/minad/consult/blob/4e7f8c6e1840dbacdaa25c67d23a6bbd451ba2c5/consult.el#L3958
(defun edblancas/consult-project-bookmark (name)
  "Same as consult-bookmark but for the current projectile project."
  (interactive
   (list
    (let ((narrow (mapcar (pcase-lambda (`(,x ,y ,_)) (cons x y))
                          consult-bookmark-narrow)))
      (consult--read
       (projectile-bookmarks)
       :prompt "Project Bookmark: "
       :state (consult--bookmark-preview)
       :category 'bookmark
       :history 'bookmark-history
       :add-history (ignore-errors (bookmark-prop-get (bookmark-make-record) 'defaults))
       :group (consult--type-group narrow)
       :narrow (consult--type-narrow narrow)))))
  (bookmark-maybe-load-default-file)
  (if (assoc name bookmark-alist)
      (bookmark-jump name)
    (bookmark-set name)))

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

;; --- djblue/portal --- ;;
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

;; NOTE: You do need to have portal on the class path and the easiest way I know
;; how is via a clj user or project alias.
(setq cider-clojure-cli-aliases ":portal")
(setq cider-lein-parameters "with-profile +portal repl :headless :host localhost")

;; same as cider-ns-refresh
;; https://docs.cider.mx/cider/usage/misc_features.html#reloading-code
(defun edblancas/refresh-repl ()
  (interactive)
  (cider-nrepl-sync-request:eval "(do (require '[clojure.tools.namespace.repl]) (clojure.tools.namespace.repl/refresh))"))

;; see how to blacklist minibuffer, treemacs, magit and jet transiet windows, etc.
;; (use-package! edwina
;;   :config
;;   (setq display-buffer-base-action '(display-buffer-below-selected))
;;   (edwina-setup-dwm-keys 'super)
;;   (edwina-mode 1))

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

(use-package! corfu
  :init
  (global-corfu-mode))

;; https://github.com/minad/corfu#completing-in-the-minibuffer
(defun corfu-enable-in-minibuffer ()
  "Enable Corfu in the minibuffer if `completion-at-point' is bound."
  (when (where-is-internal #'completion-at-point (list (current-local-map)))
    ;; (setq-local corfu-auto nil) ;; Enable/disable auto completion
    (setq-local corfu-echo-delay nil ;; Disable automatic echo and popup
                corfu-popupinfo-delay nil)
    (corfu-mode 1)))

(add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic ))

(defun edblancas/search-notes-files ()
  "Grep for a string in `notes' using `rg'."
  (interactive)
  (consult-ripgrep "~/Dropbox/dev/current/notes" ""))

(setq highlight-indent-guides-auto-enabled nil)

;; https://github.com/hungyiloo/doom-emacs-conf/blob/master/autoload/hydras.el
;; more useful hydras: windows and paredit/smartparens
(defun my/mc-select-matches ()
  (interactive)
  (evil-mc-execute-for-all-cursors
   (lambda (args)
     (interactive)
     (when (thing-at-point-looking-at (caar evil-mc-pattern))
       (if (alist-get :real args)
           (progn
             (goto-char (match-beginning 0))
             (evil-visual-char)
             (goto-char (- (match-end 0) 1)))
         (setq region (evil-mc-create-region
                       (match-beginning 0)
                       (match-end 0)
                       'char)))))))

(defhydra my/mc-hydra (:color pink
                       :hint nil
                       :pre (progn
                              ;; make sure point is after mark, otherwise matching stuffs up
                              (if (and (region-active-p) (> (mark) (point)))
                                  (exchange-point-and-mark))
                              (evil-mc-pause-cursors))
                       :post (progn
                               (evil-mc-resume-cursors)
                               (when evil-mc-pattern (my/mc-select-matches))))
  "
_z_: match all     _J_: make & go down   _._: toggle here
_m_: make & next   _K_: make & go up     _r_: remove last
_M_: make & prev   _I_: make visual beg  _R_: remove all
_n_: skip & next   _A_: make visual end  _!_: pause/resume
_N_: skip & prev   ^ ^                   _p_: paste multiple

Current pattern: %s(replace-regexp-in-string \"%\" \"%%\" (or (caar evil-mc-pattern) \"\"))  "
  ("z" #'evil-mc-make-all-cursors)
  ("m" #'evil-mc-make-and-goto-next-match)
  ("M" #'evil-mc-make-and-goto-prev-match)
  ("n" #'evil-mc-skip-and-goto-next-match)
  ("N" #'evil-mc-skip-and-goto-prev-match)
  ("J" #'evil-mc-make-cursor-move-next-line)
  ("K" #'evil-mc-make-cursor-move-prev-line)
  ("I" #'evil-mc-make-cursor-in-visual-selection-beg :color blue)
  ("A" #'evil-mc-make-cursor-in-visual-selection-end :color blue)
  ("." #'+multiple-cursors/evil-mc-toggle-cursor-here)
  ("r" #'+multiple-cursors/evil-mc-undo-cursor)
  ("R" #'evil-mc-undo-all-cursors)
  ("p" #'my/yank-rectangle-push-lines-after :color blue)
  ("P" #'my/yank-rectangle-push-lines :color blue)
  ("!" #'+multiple-cursors/evil-mc-toggle-cursors)
  ("q" nil "quit" :color blue)
  ("<escape>" nil "quit" :color blue))

(defhydra my/sp-hydra (:color amaranth
                       :hint nil
                       :pre (recenter)
                       :post (recenter))
  "
_e_: forward sexp     _RET_: down sexp        _x_: kill region      _,_: slurp backward ^^^^^^^^^^  _~_: transpose   ___: splice
_b_: backward sexp    _S-<return>_: up sexp   _d_: kill sexp        _._: slurp forward  ^^^^^^^^^^  _!_: raise       _<delete>_: splice kill forward
_w_: next sexp        _v_: select sexp        _D_: kill whole line  _<_: barf backward  ^^^^^^^^^^  _+_: join        _<backspace>_: splice kill backward
_E_: sexp end         _V_: clear selection    _c_: comment          _>_: barf forward   ^^^^^^^^^^  _|_: split
_B_: sexp beginning   _y_: yank selection     _p_: paste after      ^ ^                 ^^^^^^^^^^  _=_: clone
_RET_: down sexp      _Y_: yank sexp          _P_: paste before     _{__[__(__)__]__}_: wrap        _%_: convolute

_u_: undo  _C-r_: redo  _C-SPC_: set mark  _s_: toggle strict  "
  ("0" #'evil-beginning-of-line)
  ("$" #'evil-end-of-line)
  ("^" #'evil-first-non-blank)
  ("j" #'evil-next-line)
  ("k" #'evil-previous-line)
  ("h" #'evil-backward-char)
  ("l" #'evil-forward-char)
  ("y" #'evil-yank)
  ("Y" #'sp-copy-sexp)
  ("p" #'evil-paste-after)
  ("P" #'evil-paste-before)
  ("e" #'sp-forward-sexp)
  ("b" #'sp-backward-sexp)
  ("w" #'sp-next-sexp)
  ("B" #'sp-beginning-of-sexp)
  ("E" #'sp-end-of-sexp)
  ("S-<return>" #'sp-up-sexp)
  ("RET" #'sp-down-sexp)
  ("v" #'sp-mark-sexp)
  ("V" #'evil-exit-visual-state)
  ("o" #'exchange-point-and-mark)
  ("x" #'sp-kill-region)
  ("d" #'sp-kill-sexp)
  ("D" #'sp-kill-whole-line)
  ("c" #'evilnc-comment-operator)
  ("(" #'sp-wrap-round)
  (")" #'sp-wrap-round)
  ("[" #'sp-wrap-square)
  ("]" #'sp-wrap-square)
  ("{" #'sp-wrap-curly)
  ("}" #'sp-wrap-curly)
  ("<" #'sp-backward-barf-sexp)
  (">" #'sp-forward-barf-sexp)
  ("," #'sp-backward-slurp-sexp)
  ("." #'sp-forward-slurp-sexp)
  ("~" #'sp-transpose-sexp)
  ("!" #'sp-raise-sexp)
  ("+" #'sp-join-sexp)
  ("|" #'sp-split-sexp)
  ("=" #'sp-clone-sexp)
  ("%" #'sp-convolute-sexp)
  ("_" #'sp-splice-sexp)
  ("<delete>" #'sp-splice-sexp-killing-forward)
  ("<backspace>" #'sp-splice-sexp-killing-backward)
  ("z" #'evil-scroll-line-to-center)
  ("C-SPC" #'evil-visual-char)
  ("u" #'evil-undo)
  ("C-r" #'evil-redo)
  ("s" #'smartparens-strict-mode :exit t)
  ("q" nil "quit" :color blue)
  ("C-g" nil "quit" :color blue)
  ("<escape>" nil "quit" :color blue))

(use-package! org-roam
  :init
  (setq org-roam-directory (file-truename "~/Dropbox/org-roam/"))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

(add-hook 'cider-clojure-interaction-mode-hook
          (lambda () (add-to-list 'completion-at-point-functions #'cider-complete-at-point)))

;; --- org-modern suggestion settings --- ;;
(setq
 ;; Edit settings
 org-auto-align-tags nil
 org-tags-column 0
 org-fold-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-ellipsis "…"

 ;; Agenda styling
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string
 "⭠ now ─────────────────────────────────────────────────")

(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

;; --- jinx --- ;;
(dolist (hook '(text-mode-hook prog-mode-hook conf-mode-hook))
  (add-hook hook #'jinx-mode))

(after! vertico
  :config
  (vertico-multiform-mode 1)
  (setq! vertico-multiform-categories
        '((jinx grid (vertico-grid-annotate . 20)))))

;; this option in the vertico-multiform-categories
;; don't display the whole buffer in the right
;; like docs, is something in my config for errors or
;; cider
;; (consult-grep buffer)

;; --- tempel --- ;;
;; https://github.com/minad/tempel#configuration
(use-package! tempel
  :config
  (setq! tempel-trigger-prefix "<")
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-complete
                      completion-at-point-functions)))
  (add-hook 'conf-mode-hook 'tempel-setup-capf)
  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf))

;;(setq lsp-enable-snippet nil)

;; Only want yassnippets for expand the clojure-lsp snippets.
;; That's why :snippets and :template-files doom modules are disabled.
(add-hook 'prog-mode-hook #'yas-minor-mode)

(setq! doom-themes-treemacs-theme "doom-colors")

;; see https://github.com/emacs-evil/evil-cleverparens#installation
(setq evil-move-beyond-eol t)

;; (require 'evil-cleverparens-text-objects)
;; from evil-cleverparens.el
;; evil-cp--enable-text-objects
(defun evil-cp-enable-text-objects ()
  "Enables text-objects defined in evil-cleverparens."
  ;; f is not working with tree-sitter
  (define-key evil-outer-text-objects-map "f" #'evil-cp-a-form)
  (define-key evil-inner-text-objects-map "f" #'evil-cp-inner-form)
  (define-key evil-outer-text-objects-map "c" #'evil-cp-a-comment)
  (define-key evil-inner-text-objects-map "c" #'evil-cp-inner-comment)
  (define-key evil-outer-text-objects-map "d" #'evil-cp-a-defun)
  (define-key evil-inner-text-objects-map "d" #'evil-cp-inner-defun)
  (define-key evil-outer-text-objects-map "W" #'evil-cp-a-WORD)
  (define-key evil-inner-text-objects-map "W" #'evil-cp-inner-WORD))
(evil-cp-enable-text-objects)

(after! clojure-mode
  (remove-hook 'clojure-mode-hook #'rainbow-delimiters-mode))
(after! elisp-mode
  (remove-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

(add-hook 'prog-mode-hook #'highlight-parentheses-mode)

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

;; for both grep and ripgrep
(after! grep
  (progn
    (add-to-list 'grep-find-ignored-files ".transit*")
    (add-to-list 'grep-find-ignored-directories ".cache")
    (add-to-list 'grep-find-ignored-directories ".cpcache")
    (add-to-list 'grep-find-ignored-directories ".clj-kondo")))

(use-package! consult-notes
  :config
  (add-hook! 'org-mode-hook #'consult-notes-org-roam-mode))

(load! "+bindings")
