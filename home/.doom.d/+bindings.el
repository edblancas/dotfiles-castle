;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

;; or https://github.com/hlissner/doom-emacs/blob/develop/docs/faq.org#my-new-keybinds-dont-work
(undefine-key! projectile-mode-map "C-]")
(undefine-key! evil-motion-state-map "C-]")
(undefine-key! clj-refactor-mode-map "M-<up>" "M-<down>")
(undefine-key! paredit-mode-map "M-<up>" "M-<down>")
(undefine-key! global-map "M-<up>" "M-<down>")
(undefine-key! global-map "<f16>")
(undefine-key! global-map "<f18>")
(undefine-key! global-map "M-SPC")
(undefine-key! evil-normal-state-map "s-1")
(undefine-key! global-map "<f2>")
(undefine-key! global-map "M-e")
(undefine-key! global-map "s-x")
(undefine-key! global-map "s-o")
(undefine-key! global-map "C-j")
(undefine-key! global-map "C-k")
(undefine-key! global-map "C-SPC")

(global-set-key (kbd "s-e") #'recentf-open-files)
(global-set-key (kbd "M-S-<up>") #'drag-stuff-up)
(global-set-key (kbd "M-S-<down>") #'drag-stuff-down)
(global-set-key (kbd "M-<up>") #'er/expand-region)
(global-set-key (kbd "M-<down>") (lambda () (interactive) (er/expand-region -1)))
(global-set-key (kbd "<f3>") #'bookmark-set)
(global-set-key (kbd "s-<f3>") #'edblancas/consult-project-bookmark)  ;; only bookmarks of the project
(global-set-key (kbd "M-s-<f3>") #'consult-bookmark)  ;; all bookmarks
(global-set-key (kbd "M-<f3>") #'bookmark-delete)  ;; all bookmarks
(global-set-key (kbd "M-A") #'execute-extended-command)
(global-set-key (kbd "s-1") #'+treemacs/toggle)
(global-set-key (kbd "s-g") #'evil-mc-make-and-goto-next-match)
(global-set-key (kbd "s-G") #'evil-mc-make-and-goto-prev-match)
(global-set-key (kbd "M-s-g") #'evil-mc-make-all-cursors)
(global-set-key (kbd "C-s-g") #'evil-mc-make-cursor-in-visual-selection-beg)
(global-set-key (kbd "<f2>") #'flycheck-next-error)
(global-set-key (kbd "S-<f2>") #'flycheck-previous-error)
(global-set-key (kbd "s-<f2>") #'consult-flycheck)
(global-set-key (kbd "M-s-<f2>") #'consult-lsp-diagnostics)
(global-set-key (kbd "M-O") #'find-file)
(global-set-key (kbd "C-M-s-n") #'edblancas/search-notes-files)

;;(global-set-key (kbd "<f16>") #')  ;; someting like run like idea
;;(global-set-key (kbd "<f17>") #')  ;; someting like focus editor like idea
(global-set-key (kbd "<f18>") #'+vterm/toggle)

(define-key evil-normal-state-map (kbd "-") #'dired-jump)

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

(map! :i

      :des "Insert pair of partenthesis"
      "C-;" #'insert-open-close-paren
      ;; Alternative tempel-expand
      "M-+" #'tempel-complete
      "M-*" #'tempel-insert)

;; https://github.com/doomemacs/doomemacs/issues/890
(map! :map evil-window-map
      "o" #'doom/window-maximize-buffer)

(map! :leader

      :desc "Open dotfiles"
      "f T" #'open-dotfiles

      :desc "Find file in dotfiles"
      "f t" #'find-in-dotfiles

      :desc "Find file other window"
      "f o" #'find-file-other-window

      :desc "List processes"
      "l" #'list-processes

      :desc "doom/window-enlargen"
      "w z" #'doom/window-enlargen

      :desc "Clear search highlight"
      "s c" #'evil-ex-nohighlight

      :desc "Toggle truncate lines"
      "t t" #'toggle-truncate-lines)

(after! paredit
  (define-key paredit-mode-map (kbd "C-<left>") nil)
  (define-key paredit-mode-map (kbd "C-<right>") nil)
  (define-key paredit-mode-map (kbd "C-}") nil)

  (map! :nvi
        "C-s-l" #'paredit-forward-slurp-sexp
        "C-s-h" #'paredit-backward-slurp-sexp
        "C-s-k" #'paredit-forward-barf-sexp
        "C-s-j" #'paredit-backward-barf-sexp

        "C-S-l" #'paredit-forward
        "C-S-h" #'paredit-backward
        "C-S-k" #'paredit-backward-up
        "C-S-j" #'paredit-forward-down
        "C-S-i" #'paredit-forward-up
        "C-S-u" #'paredit-backward-down

        "M-o" #'paredit-raise-sexp

        "M-s-k" #'paredit-kill
        "s-k" #'kill-sexp
        "M-k" #'paredit-splice-sexp-killing-backward
        "M-j" #'paredit-splice-sexp-killing-forward

        "M-s" #'paredit-splice-sexp
        "M-S-s" #'paredit-split-sexp
        "M-S-j" #'paredit-join-sexp

        "M-s-<down>" #'transpose-sexp
        "M-s-<up>" #'reverse-transpose-sexp

        "s-[" #'paredit-wrap-square
        "s-{" #'paredit-wrap-curly
        "s-(" #'paredit-wrap-round
        "s-\"" #'paredit-meta-doublequote
        "s-]" #'paredit-close-bracket-and-newline
        "s-}" #'paredit-close-curly-and-newline
        "s-)" #'paredit-close-parenthesis-and-newline
        "s-'" #'paredit-meta-doublequote-and-newline

        "M-%" #'paredit-convolute-sexp))

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
      "C-}" #'lsp-ui-peek-find-references
      "C-]" #'lsp-find-definition
      "s-y" #'lsp-ui-peek-find-definitions
      "<f1>" #'lsp-describe-thing-at-point
      "C-M-o" #'lsp-clojure-clean-ns
      "M-s-l" #'lsp-format-buffer
      "M-<return>" #'lsp-execute-code-action
      "C-M-s-g" #'lsp-iedit-linked-ranges)

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
      "C-S-O" #'consult-lsp-symbols
      "s-o" #'consult-lsp-file-symbols
      "s-<f16>" #'portal.api/open
      :localleader
      :prefix ("o" . "utils")
      "R" #'edblancas/refresh-repl
      "p" #'portal.api/open
      "c" #'portal.api/clear
      "r" #'hydra-cljr-help-menu/body
      :prefix "e"
      "c" #'cider-eval-defun-to-comment)

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
      "s-F" #'consult-ripgrep
      "s-e" #'projectile-switch-to-buffer
      "C-M-s-p" #'projectile-switch-project)

(map! :after magit
      :map magit-map
      "C-x g" #'magit-status)

(map! :after cider-mode
      :map cider-mode-map
      "S-s-." #'cider-test-run-test
      "S-s-," #'cider-test-run-ns-tests
      "s-L" #'cider-eval-buffer
      "s-P" #'cider-eval-defun-at-point
      "C-S-p" #'cider-eval-last-sexp
      "C-P" #'cider-eval-sexp-at-point
      "s-N" #'cider-repl-set-ns
      :map cider-repl-mode-map
      "C-c M-o" #'cider-repl-clear-buffer)

(map! :after cape
      :i
      "C-c p f" #'cape-file
      "C-c p :" #'cape-emoji
      "C-c p h" #'cape-history
      "C-c p d" #'cape-dabbrev)

(map! :after consult
      "M-h" #'consult-history)

(after! flycheck
  (map! :leader
        (:prefix-map ("c" . "code")
         "x" flycheck-command-map)))

(map!
 (:when (modulep! :editor multiple-cursors)
   :prefix "g"
   :nv "z" #'my/mc-hydra/body)
 (:prefix "gs"
    :nv "p" #'my/sp-hydra/body))

(after! org-roam
  :map org-mode-map
  "C-M-i" #'completion-at-point)

;; the right alt is for inserting special chars
(map! :after jinx
      ;; use left alt + shift + 4
      "M-$" #'jinx-correct
      ;; use left ctrl + alt + shift + 4
      "C-M-$" #'jinx-languages)

;; https://joaotavora.github.io/yasnippet/faq.html#org5f4a84d
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
;;(define-key yas-minor-mode-map (kbd "<the new key>") yas-maybe-expand)

;;keys for navigation
(define-key yas-keymap [(tab)]       nil)
(define-key yas-keymap (kbd "TAB")   nil)
(define-key yas-keymap [(shift tab)] nil)
(define-key yas-keymap [backtab]     nil)
(define-key yas-keymap (kbd "M-<down>") 'yas-next-field)
(define-key yas-keymap (kbd "M-<up>") 'yas-prev-field)

(map! :map fennel-mode-map
      :localleader
      "'" #'fennel-format
      "z" #'fennel-repl
      "o" #'fennel-repl-clear-buffer)
