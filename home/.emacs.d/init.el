;; ─────────────────────────────────── Set up 'package' ───────────────────────────────────
(require 'package)

;; Add melpa to package archives.
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Load and activate emacs packages. Do this first so that the packages are loaded before
;; you start trying to modify them.  This also sets the load path.
(package-initialize)

;; Install 'use-package' if it is not installed.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))


;; ───────────────────────────────── Use better defaults ────────────────────────────────
(setq-default
 ;; Don't use the compiled code if its the older package.
 load-prefer-newer t

 ;; Do not show the startup message.
 inhibit-startup-message t

 ;; Do not put 'customize' config in init.el; give it another file.
 custom-file "~/.emacs.d/custom-file.el"

 ;; 72 is too less for the fontsize that I use.
 fill-column 80

 ;; Use your name in the frame title. :)
 frame-title-format (format "%s's Emacs" (if (or (equal user-login-name "dan")
                                                 (equal user-login-name "daniel.blancas"))
                                             "Dan"
                                           (capitalize user-login-name)))

 ;; Do not create lockfiles.
 create-lockfiles nil

 ;; Don't use hard tabs
 indent-tabs-mode nil

 ;; Emacs can automatically create backup files. This tells Emacs to put all backups in
 ;; ~/.emacs.d/backups. More info:
 ;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Backup-Files.html
 backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))

 ;; Do not autosave.
 auto-save-default nil

 ;; Allow commands to be run on minibuffers.
 enable-recursive-minibuffers t

 ;; Do not ring bell
 ring-bell-function 'ignore)

;; Delete regions
(cua-selection-mode t)

;; Load `custom-file` manually as we have modified the default path.
(load-file custom-file)

;; Change all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; because emacs-mac changes the command for meta
;; https://github.com/railwaycat/homebrew-emacsmacport
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta))

(global-set-key (kbd "s-e") 'counsel-recentf)

;; Delete whitespace just when a file is saved.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Automatically update buffers if file content on the disk has changed.
(global-auto-revert-mode t)

(column-number-mode 1)

(use-package expand-region
  :ensure t
  :bind  (("M-<up>" . er/expand-region)
          ("M-<down>" . er/contract-region)))

;; ─────────────────────────── Disable unnecessary UI elements ──────────────────────────
(progn

  ;; Do not show tool bar.
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

  ;; Do not show scroll bar.
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

  ;; Highlight line on point.
  (global-hl-line-mode t))


;; ───────────────────────── Better interaction with X clipboard ────────────────────────
(setq-default
 ;; Makes killing/yanking interact with the clipboard.
 x-select-enable-clipboard t

 ;; Save clipboard strings into kill ring before replacing them. When
 ;; one selects something in another program to paste it into Emacs, but
 ;; kills something in Emacs before actually pasting it, this selection
 ;; is gone unless this variable is non-nil.
 save-interprogram-paste-before-kill t

 ;; Shows all options when running apropos. For more info,
 ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html.
 apropos-do-all t

 ;; Mouse yank commands yank at point instead of at click.
 mouse-yank-at-point t)


;; ───────────────────────────────── Unbind keys ────────────────────────────────────────
(global-unset-key (kbd "s-P"))
(global-unset-key (kbd "s-L"))
(defun insert-open-close-paren ()
  (interactive)
  (insert "()")
  (backward-char 1))
(global-set-key (kbd "C-;") #'insert-open-close-paren)

;; ───────────────────── Additional packages and their configurations ─────────────────────
(require 'use-package)

;; Add `:doc' support for use-package so that we can use it like what a doc-strings is for
;; functions.
(eval-and-compile
  (add-to-list 'use-package-keywords :doc t)
  (defun use-package-handler/:doc (name-symbol _keyword _docstring rest state)
    "An identity handler for :doc.
     Currently, the value for this keyword is being ignored.
     This is done just to pass the compilation when :doc is included
     Argument NAME-SYMBOL is the first argument to `use-package' in a declaration.
     Argument KEYWORD here is simply :doc.
     Argument DOCSTRING is the value supplied for :doc keyword.
     Argument REST is the list of rest of the  keywords.
     Argument STATE is maintained by `use-package' as it processes symbols."

    ;; just process the next keywords
    (use-package-process-keywords name-symbol rest state)))


;; ─────────────────────────────────── Generic packages ───────────────────────────────────
(use-package delight
  :ensure t
  :delight)

(use-package uniquify
  :doc "Naming convention for files with same names"
  :config
  (setq uniquify-buffer-name-style 'forward)
  :delight)

(use-package recentf
  :doc "Recent buffers in a new Emacs session"
  :config
  (setq recentf-auto-cleanup 'never
        recentf-max-saved-items 1000
        recentf-save-file (concat user-emacs-directory ".recentf"))
  (recentf-mode t)
  :delight)

(use-package ibuffer
  :doc "Better buffer management"
  :delight)

(use-package projectile
  :doc "Project navigation"
  :ensure t
  :config
  ;; Use it everywhere
  (projectile-mode t)
  :bind ("s-O" . projectile-find-file)
  :delight)

(use-package magit
  :doc "Git integration for Emacs"
  :ensure t
  :bind ("C-x g" . magit-status)
  :delight)

(use-package which-key
  :doc "Prompt the next possible key bindings after a short wait"
  :ensure t
  :config
  (which-key-mode t)
  :delight)

(use-package ivy
  :doc "A generic completion mechanism"
  :ensure t
  :config
  (ivy-mode t)
  (setq ivy-use-virtual-buffers t

        ;; Display index and count both.
        ivy-count-format "(%d/%d) "

        ;; By default, all ivy prompts start with `^'. Disable that.
        ivy-initial-inputs-alist nil)

  :bind (("C-x b" . ivy-switch-buffer)
         ("C-x B" . ivy-switch-buffer-other-window)
         ("C-c C-r" . ivy-resume))
  :delight)

(use-package ivy-rich
  :doc "Have additional information in empty space of ivy buffers."
  :disabled t
  :ensure t
  :custom
  (ivy-rich-path-style 'abbreviate)
  :config
  (setcdr (assq t ivy-format-functions-alist)
          #'ivy-format-function-line)
  (ivy-rich-mode 1)
  :delight)

(use-package swiper
  :doc "A better search"
  :ensure t
  :bind (("S-s-f" . swiper-isearch)
         ("s-s" . isearch-forward-regexp))
  :delight)

(use-package counsel
  :doc "Ivy enhanced Emacs commands"
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("M-s-o" . counsel-find-file)
         ("C-'" . counsel-imenu)
         ("C-c s" . counsel-rg)
         ("M-y" . counsel-yank-pop)
         :map counsel-find-file-map
         ("RET" . ivy-alt-done))
  :delight)

(use-package git-gutter
  :doc "Shows modified lines"
  :ensure t
  :config
  (setq git-gutter:modified-sign "|")
  (setq git-gutter:added-sign "|")
  (setq git-gutter:deleted-sign "|")
  (global-git-gutter-mode t)
  :delight)

(use-package git-timemachine
  :doc "Go through git history in a file"
  :ensure t
  :delight)

(use-package region-bindings-mode
  :doc "Define bindings only when a region is selected."
  :ensure t
  :config
  (region-bindings-mode-enable)
  :delight)

(use-package multiple-cursors
  :doc "A minor mode for editing with multiple cursors"
  :ensure t
  :config
  (setq mc/always-run-for-all t)
  :bind
  ;; Use multiple cursor bindings only when a region is active
  (:map region-bindings-mode-map
        ("C->" . mc/mark-next-like-this)
        ("C-<" . mc/mark-previous-like-this)
        ("C-c a" . mc/mark-all-like-this)
        ("C-c h" . mc-hide-unmatched-lines-mode)
        ("C-c l" . mc/edit-lines))
  :delight)

(use-package esup
  :doc "Emacs Start Up Profiler (esup) benchmarks Emacs
        startup time without leaving Emacs."
  :ensure t
  :delight)

(use-package pdf-tools
  :doc "Better pdf viewing"
  :disabled t
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :bind (:map pdf-view-mode-map
              ("j" . image-next-line)
              ("k" . image-previous-line))
  :delight)

(use-package define-word
  :doc "Dictionary in Emacs."
  :ensure t
  :bind ("C-c w" . define-word-at-point)
  :delight)

(use-package exec-path-from-shell
  :doc "MacOS does not start a shell at login. This makes sure
        that the env variable of shell and GUI Emacs look the
        same."
  :ensure t
  :if (eq system-type 'darwin)
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-envs
     '("PATH" "ANDROID_HOME" "LEIN_USERNAME" "LEIN_PASSPHRASE"
       "LEIN_JVM_OPTS" "NPM_TOKEN" "LANGUAGE" "LANG" "LC_ALL"
       "MOBY_ENV" "JAVA_8_HOME" "JAVA_7_HOME" "JAVA_HOME" "PS1"
       "NVM_DIR" "GPG_TTY")))
  :delight)

(use-package diminish
  :doc "Hide minor modes from mode line"
  :ensure t
  :delight)

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :delight)


;; ───────────────────────────────────── Code editing ─────────────────────────────────────
(use-package company
  :doc "COMplete ANYthing"
  :ensure t
  :bind (:map
         global-map
         ("TAB" . company-complete-common-or-cycle)
         ;; Use hippie expand as secondary auto complete. It is useful as it is
         ;; 'buffer-content' aware (it uses all buffers for that).
         ("M-/" . hippie-expand)
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :config
  (setq company-idle-delay 0.1)
  (global-company-mode 1)

  ;; Configure hippie expand as well.
  (setq hippie-expand-try-functions-list
        '(try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill
          try-complete-lisp-symbol-partially
          try-complete-lisp-symbol))

  ;; https://emacs-lsp.github.io/lsp-mode/tutorials/clojure-guide/
  (setq company-minimum-prefix-length 1)

  (require 'color)
  (let ((bg (face-attribute 'default :background)))
    (custom-set-faces
     `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
     `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
     `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
     `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
     `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))

  :delight)

(use-package paredit
  :doc "Better handling of parenthesis when writing Lisp"
  :ensure t
  :init
  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'cider-repl-mode-hook 'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook 'paredit-mode)
  (add-hook 'lisp-mode-hook 'paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'paredit-mode)
  :config
  (show-paren-mode t)
  (defun reverse-transpose-sexps (arg)
    (interactive "*p")
    (transpose-sexps (- arg))
    ;; when transpose-sexps can no longer transpose, it throws an error and code
    ;; below this line won't be executed. So, we don't have to worry about side
    ;; effects of backward-sexp and forward-sexp.
    (backward-sexp (1+ arg))
    (forward-sexp 1))
  :config
  (setq paredit-splice-sexp-killing-backward nil)
  :bind (("s-[" . paredit-wrap-square)
         ("s-{" . paredit-wrap-curly)
         ("s-(" . paredit-wrap-round)
         ("s-\"" . paredit-meta-doublequote)
         ("s-]" . paredit-bracket-and-newline)
         ("s-}" . paredit-curly-and-newline)
         ("s-)" . paredit-round-and-newline)
         ("s-'" . paredit-meta-doublequote-and-newline)
         ("M-C-J" . paredit-join-sexps)
         ("M-s-K" . paredit-kill)
         ("M-C-J" . paredit-kill-kill-region)
         ("s-<right>" . paredit-forward)
         ("s-<left>" . paredit-backward)
         ("C-s-l" . paredit-forward-slurp-sexp)
         ("C-s-h" . paredit-backward-slurp-sexp)
         ("C-s-k" . paredit-forward-barf-sexp)
         ("C-s-j" . paredit-backward-barf-sexp)
         ("M-s" . paredit-splice-sexp)
         ("M-o" . paredit-rise-sexp)
         ("C-M-j" . paredit-join-sexp)
         ("M-k" . transpose-sexp)
         ("M-j" . reverse-transpose-sexp)))

(use-package rainbow-delimiters
  :doc "Colorful paranthesis matching"
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  :delight)


;; ──────────────────────────────── Programming languages ───────────────────────────────
(use-package clojure-mode
  :doc "A major mode for editing Clojure code"
  :ensure t
  :bind (("M-C-," . clojure-thread)
         ("M-C-." . clojure-unwind))
  :init
  (add-hook 'clojure-mode-hook
            (lambda () (local-set-key (kbd "C-S-O") #'lsp-ivy-workspace-symbol)))
  (add-hook 'clojure-mode-hook 'global-prettify-symbols-mode)
  (add-hook 'clojure-mode-hook 'lsp)
  (setq clojure-indent-style 'align-arguments)
  (setq clojure-align-forms-automatically t)
  (setq clojure-toplevel-inside-comment-form t))

(use-package clojure-mode-extra-font-locking
  :doc "Extra syntax highlighting for clojure"
  :ensure t
  :delight)

;; https://emacs-lsp.github.io/lsp-mode/tutorials/clojure-guide/
;; https://github.com/practicalli/spacemacs.d/blob/live/init.el
(use-package lsp-mode
  :ensure t
  :bind
  (("s-C-]" . lsp-clojure-cycle-coll)
   ("C-]" . lsp-find-definition)
   ("C-}" . lsp-find-references))
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-enable-on-type-formatting t)
  (setq lsp-enable-indentation t)
  (setq lsp-enable-snippet t)
  (setq lsp-enable-symbol-highlighting t)
  ;; Show lint error indicator in the mode line
  (setq lsp-modeline-diagnostics-enable t)
  (setq lsp-lens-enable nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  ;; Optimization for large files
  (setq lsp-file-watch-threshold 10000)
  (setq lsp-log-io nil)

  (setq
    lsp-signature-auto-activate t
    lsp-signature-doc-lines 1)
  (setq lsp-signature-render-documentation t)
  (setq lsp-completion-show-detail t)
  (setq lsp-completion-show-kind t)
  :hook ((clojure-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :delight)

;; https://github.com/practicalli/spacemacs.d/blob/live/init.el
(use-package lsp-ui
  :doc "UI integrations for lsp-mode"
  :config
  (setq lsp-ui-doc-show-with-cursor nil)   ;; doc popup for cursor
  (setq lsp-ui-doc-show-with-mouse nil)   ;; doc popup for cursor
  (setq lsp-ui-doc-include-signature t)    ;; include function signature
  (setq lsp-ui-doc-position 'at-point)
  ;; code actions and diagnostics text as right-hand side of buffer
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-sideline-show-code-actions nil)
  :ensure t
  :delight)

(use-package lsp-ivy
  :doc "This package provides an interactive ivy interface to the workspace symbol functionality offered by lsp-mode"
  :ensure t
  :delight)

(use-package lsp-origami
  :ensure t
  :init
  (add-hook 'lsp-after-open-hook #'lsp-origami-try-enable)
  :delight)

(use-package which-key
  :doc "Emacs package that displays available keybindings in popup"
  :ensure t
  :delight)

(use-package cider
  :doc "Integration with a Clojure REPL cider"
  :ensure t
  :config
  (setq cider-eldoc-display-for-symbol-at-point nil) ; disable cider showing eldoc during symbol at point

  ;; Where to store the cider history.
  (setq cider-repl-history-file "~/.emacs.d/cider-history")

  ;; Wrap when navigating history.
  (setq cider-repl-wrap-history t)

  ;; Attempt to jump at the symbol under the point without having to press RET
  (setq cider-prompt-for-symbol nil)

  (setq cider-repl-use-pretty-printing t)

  ;; Log client-server messaging in *nrepl-messages* buffer
  (setq nrepl-log-messages nil)

  ;; REPL should expect input on the next line + unnecessary palm trees!
  (defun cider-repl-prompt-custom (namespace)
    "Return a prompt string that mentions NAMESPACE."
    (format "🌴 %s 🌴 \n" namespace))

  (setq cider-repl-prompt-function 'cider-repl-prompt-custom)

  :bind (:map
         cider-mode-map
         ("S-s-." . cider-test-run-test)
         ("S-s-," . cider-test-run-ns-tests)
         ("s-L" . cider-eval-buffer)
         ("s-P" . cider-eval-defun-at-point)
         ("C-S-p" . cider-eval-last-sexp)
         ("C-P" . cider-eval-sexp-at-point)
         ;; cider changes the namespace automatically for the curr buffer
         ;; SO, NOT NEEDED
         ("s-N" . cider-repl-set-ns)
         :map
         cider-repl-mode-map
         ("C-c M-o" . cider-repl-clear-buffer))
  :delight)

(use-package flycheck
  :doc "On the fly syntax checking for GNU Emacs"
  :ensure t
  :delight)

(use-package smartparens
  :ensure t
  :commands (sp-point-in-string-or-comment sp-forward-symbol sp-split-sexp sp-newline sp-up-sexp)
  :init
  (add-hook 'clojure-mode-hook #'smartparens-mode))

;; https://emacs-lsp.github.io/lsp-mode/tutorials/clojure-guide/
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

(use-package clojure-snippets
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  :delight)

(use-package shell-pop
  :ensure t
  :init
  (setq shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
  (setq shell-pop-term-shell "/bin/zsh"))

(use-package json-mode
  :ensure t
  :init
  (defconst json-mode-standard-file-ext '(".json" ".jsonld" ".json.base")
    "List of JSON file extensions."))

;; ───────────────────────────────────────── VIM ────────────────────────────────────────
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;; ligatures only for osx
(if (fboundp 'mac-auto-operator-composition-mode)
    (mac-auto-operator-composition-mode))

;; prefix
(define-prefix-command 'leader-map)
(global-set-key (kbd "C-,") 'leader-map)
(define-key leader-map (kbd "w") 'save-buffer)
(define-key leader-map (kbd "c") 'cider-jack-in)
(define-key leader-map (kbd "s") 'shell-pop)
(define-key leader-map (kbd "b") 'ibuffer)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :init
  ;; `s' for surround instead of `substitute'
  ;; see motivation here:
  ;; https://github.com/syl20bnr/spacemacs/blob/develop/doc/DOCUMENTATION.org#the-vim-surround-case
  (evil-define-key 'visual evil-surround-mode-map "s" 'evil-surround-region)
  (evil-define-key 'visual evil-surround-mode-map "S" 'evil-substitute)
  :config
  (global-evil-surround-mode 1))

(use-package evil-textobj-line
  :ensure t)

(use-package evil-nerd-commenter
  :ensure t
  :commands evilnc-comment-operator
  :config
  (evilnc-default-hotkeys))

(use-package evil-cleverparens
  :ensure t
  :init
  (setq evil-cleverparens-use-regular-insert t)
  :config
  ;; `evil-cp-change' should move the point, see https://github.com/luxbock/evil-cleverparens/pull/71
  (evil-set-command-properties 'evil-cp-change :move-point t)
  :delight)


;; ──────────────────────────────────── Look and feel ───────────────────────────────────
(set-face-attribute 'default nil
                    :family "MonoLisa"
                    :height 160
                    :weight 'normal
                    :width 'normal)

(use-package shades-of-purple-theme
  :ensure t
  ;;:config (load-theme 'shades-of-purple t)
  :delight)

(use-package dracula-theme
  :ensure t
  :config (load-theme 'dracula t))

(use-package emojify
  :doc "Display Emoji in Emacs."
  :ensure t
  :disabled t
  :init
  (add-hook 'after-init-hook #'global-emojify-mode)
  :delight)

;; set type of line numbering (global variable)
(setq display-line-numbers-type 'relative)
;; activate line numbering in all buffers/modes
(global-display-line-numbers-mode)


;;; init.el ends here
