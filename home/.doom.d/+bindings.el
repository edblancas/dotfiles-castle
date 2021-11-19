;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

;; or https://github.com/hlissner/doom-emacs/blob/develop/docs/faq.org#my-new-keybinds-dont-work
(undefine-key! projectile-mode-map "C-]")
(undefine-key! evil-motion-state-map "C-]")
(undefine-key! clj-refactor-mode-map "M-<up>" "M-<down>")
(undefine-key! paredit-mode-map "M-<up>" "M-<down>")
(undefine-key! global-map "M-<up>" "M-<down>")
(undefine-key! global-map "<f16>")
(undefine-key! global-map "<f18>")

(global-set-key (kbd "s-e") #'counsel-recentf)
(global-set-key (kbd "C-;") #'insert-open-close-paren)
(global-set-key (kbd "M-S-<up>") #'drag-stuff-up)
(global-set-key (kbd "M-S-<down>") #'drag-stuff-down)
(global-set-key (kbd "M-<up>") #'er/expand-region)
(global-set-key (kbd "M-<down>") (lambda () (interactive) (er/expand-region -1)))
(global-set-key (kbd "<f3>") #'bookmark-set)
(global-set-key (kbd "s-<f3>") #'counsel-projectile-bookmark)  ;; only bookmarks of the project
(global-set-key (kbd "M-<f3>") #'counsel-bookmark)  ;; all bookmarks
(global-set-key (kbd "M-A") #'counsel-M-x)
;(global-set-key (kbd "s-1") #'+treemacs/toggle)  ;; taken by switch workspace
(global-set-key (kbd "s-g") #'evil-mc-make-and-goto-next-match)
(global-set-key (kbd "s-G") #'evil-mc-make-and-goto-prev-match)
(global-set-key (kbd "M-s-g") #'evil-mc-make-all-cursors)
(global-set-key (kbd "C-s-g") #'evil-mc-make-cursor-in-visual-selection-beg)

(defun bmacs-project-root ()
    "Get the path to the root of your project.
  If STRICT-P, return nil if no project was found, otherwise return
  `default-directory'."
    (let (projectile-require-project-root)
          (projectile-project-root)))
;;(global-set-key (kbd "<f16>") #')  ;; someting like run like idea
;;(global-set-key (kbd "<f17>") #')  ;; someting like focus editor like idea
(global-set-key (kbd "<f18>") #'+vterm/toggle)

(map! :nvi

      :desc "Toggle buffer full screen"
      "<f10>" #'doom/window-maximize-buffer

      :desc "increase window width"
      "C-S-<left>" (lambda () (interactive) (enlarge-window 5 t))

      :desc "decrease window width"
      "C-S-<right>" (lambda () (interactive) (enlarge-window -5 t))

      :desc "increase window height"
      "C-S-<down>" (lambda () (interactive) (enlarge-window -5))

      :desc "decrease window height"
      "C-S-<up>" (lambda () (interactive) (enlarge-window 5)))

(map! :leader

      :desc "Ivy switch buffer"
      "b i" #'ivy-switch-buffer

      :desc "Project sidebar"
      "1" #'+treemacs/toggle

      :desc "Open dotfiles"
      "f T" #'open-dotfiles

      :desc "Find file in dotfiles"
      "f t" #'find-in-dotfiles)

(after! paredit
  (define-key paredit-mode-map (kbd "C-<left>") nil)
  (define-key paredit-mode-map (kbd "C-<right>") nil)

  (map! :nvi
        "C-s-l" #'paredit-forward-slurp-sexp
        "C-s-h" #'paredit-backward-slurp-sexp
        "C-s-k" #'paredit-forward-barf-sexp
        "C-s-j" #'paredit-backward-barf-sexp

        "s-<right>" #'paredit-forward
        "s-<left>" #'paredit-backward
        "M-<left>" #'paredit-backward-up
        "M-<right>" #'paredit-forward-down

        "C-S-l" #'paredit-forward
        "C-S-h" #'paredit-backward
        "C-S-k" #'paredit-backward-up
        "C-S-j" #'paredit-forward-down

        "M-o" #'paredit-raise-sexp

        "s-k" #'paredit-kill
        "M-k" #'paredit-splice-sexp-killing-backward

        "M-s" #'paredit-splice-sexp
        "M-j" #'paredit-join-sexp

        "M-s-k" #'transpose-sexp
        "M-s-j" #'reverse-transpose-sexp

        "s-[" #'paredit-wrap-square
        "s-{" #'paredit-wrap-curly
        "s-(" #'paredit-wrap-parenthesis
        "s-\"" #'paredit-meta-doublequote
        "s-]" #'paredit-close-bracket-and-newline
        "s-}" #'paredit-close-curly-and-newline
        "s-)" #'paredit-close-parenthesis-and-newline
        "s-'" #'paredit-meta-doublequote-and-newline

        "M-?" #'paredit-convolute-sexp))

(map! :after clojure-mode
      :leader

      :desc "Search for symbol in project excluding test folders"
      "&" (lambda () (interactive) (rg-ignoring-folders (list "test" "postman")))

      :desc "Search for symbol in project excluding src folder"
      "(" (lambda () (interactive) (rg-ignoring-folders (list "src")))

      :desc "lsp-clojure cursor info"
      "-" #'lsp-clojure-cursor-info)

(map! :after lsp-mode
      :ni

      :desc "Start lsp on buffer"
      "M-l" #'lsp
      "s-p" #'lsp-signature-activate
      "s-C-]" #'lsp-clojure-cycle-coll
      "C-]" #'lsp-find-definition
      "M-]" #'lsp-find-references
      "<f1>" #'lsp-describe-thing-at-point
      "C-M-o" #'lsp-clojure-add-missing-libspec
      "M-s-l" #'lsp-format-buffer
      "M-<return>" #'lsp-execute-code-action)

(map! :after dap-mode
      :map dap-mode-map
      :n

      :desc "DAP step-in"
      "<f4>" #'dap-step-in

      :desc "DAP step-out"
      "<f5>" #'dap-step-out

      :desc "DAP next"
      "<f6>" #'dap-next

      :desc "DAP continue"
      "<f8>" #'dap-continue)

(map! :after clojure-mode
      :map clojure-mode-map
      "M-C-," #'clojure-thread
      "M-C-." #'clojure-unwind
      "C-S-O" #'lsp-ivy-workspace-symbol)

(map! :after java-mode
      :map java-mode-map
      :localleader

      :desc "Run method test"
      "t" #'dap-java-run-test-method

      :desc "Run class tests"
      "T" #'dap-java-run-test-class)

(map! :after projectile
      :map projectile-mode-map
      "s-O" #'projectile-find-file
      "s-F" #'project-find-regexp
      "C-M-s-p" #'projectile-switch-project)

(map! :after magit
      :map magit-map
      "C-x g" #'magit-status)

(map! :after ivy
      :map ivy-map
      "s-e" #'counsel-recentf
      "M-s-o" #'counsel-find-file
      "C-<tab>" #'ivy-switch-buffer)

(map! :after cider-mode
      :map cider-mode-map
      "S-s-." #'cider-test-run-test
      "S-s-," #'cider-test-run-ns-tests
      "s-L" #'cider-eval-buffer
      "s-P" #'cider-eval-defun-at-point
      "C-S-p" #'cider-eval-last-sexp
      "C-P" #'cider-eval-sexp-at-point
      ;; cider changes the namespace automatically for the curr buffer
      ;; SO, NOT NEEDED
      "s-N" #'cider-repl-set-ns
      :map cider-repl-mode-map
      "C-c M-o" #'cider-repl-clear-buffer)

; (map! :after company
;       :map global-map
;        "TAB" #'company-complete-common-or-cycle)

(after! company
  (define-key company-active-map (kbd "<f1>") #'company-quickhelp-manual-begin))
