(module config.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util config.util
             packer packer}})

(defn- safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :config.plugin. name))]
    (when (not ok?)
      (print (.. "config error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))))
  nil)

;;; plugins managed by packer
;;; :mod specifies namespace under plugin directory

(use
  ;; plugin Manager
  :wbthomason/packer.nvim {}
  ;; nvim config and plugins in Fennel
  :Olical/aniseed {:branch :develop}

  ;; theme
  :projekt0n/github-nvim-theme {:mod :theme}
  ;:catppuccin/nvim {:mod :theme}
  :ryanoasis/vim-devicons {}
  :kyazdani42/nvim-web-devicons {}

  ;; status line
  :nvim-lualine/lualine.nvim {:mod :lualine}

  ; file exploration
  :nvim-tree/nvim-tree.lua {:mod :nvim-tree}

  ;; file searching
  :nvim-telescope/telescope.nvim {:requires [:nvim-telescope/telescope-ui-select.nvim
                                             :nvim-lua/popup.nvim
                                             :nvim-lua/plenary.nvim]
                                  :mod :telescope}

  ;; unix commands helpers
  :tpope/vim-eunuch {}

  ; commeting code
  :preservim/nerdcommenter {}

  ;; clojure
  :Olical/conjure {:branch :master :mod :conjure}
  :clojure-vim/clojure.vim {:mod :clojure-vim}
  :clojure-vim/vim-jack-in {}
  :m00qek/baleia.nvim      {:mod :baleia}

  ; multicursor selector
  :mg979/vim-visual-multi {}

  ; text alignment
  :junegunn/vim-easy-align {:mod :easy-align}

  ; git helper
  :tpope/vim-fugitive {}

  ;; sexp
  :guns/vim-sexp {:mod :sexp}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :tpope/vim-surround {}

  ; tmux
  :christoomey/vim-tmux-navigator {:mod :tmux-navigator}
  :melonmanchan/vim-tmux-resizer {}

  ;; parsing system
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                    :mod :treesitter}
  ; snippets
  :L3MON4D3/LuaSnip {:requires [:saadparwaiz1/cmp_luasnip]}

  ;; lsp
  :neovim/nvim-lspconfig {:mod :lspconfig}

  ; autocomplete
  :hrsh7th/nvim-cmp {:requires [:hrsh7th/cmp-buffer
                                :hrsh7th/cmp-path
                                :hrsh7th/cmp-calc
                                :hrsh7th/cmp-nvim-lsp
                                :hrsh7th/cmp-nvim-lua
                                :hrsh7th/cmp-vsnip
                                :PaterJason/cmp-conjure]
                     :mod :cmp}
  :github/copilot.vim {}
  :ianding1/leetcode.vim {})
