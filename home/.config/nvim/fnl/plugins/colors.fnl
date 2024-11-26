[{1 :rose-pine/neovim
    :name :rose-pine}
 {1 :Mofiqul/dracula.nvim}
 {1 :folke/tokyonight.nvim
    :lazy false
    :priority 1000
    :dependencies [:nvim-tree/nvim-web-devicons]
    :config (fn []
              (let [theme (require :tokyonight)
                    theme-util (require :tokyonight.util)]
                (theme.setup {:style :night
                              :transparent vim.g.transparent_enabled
                              :styles {:comments {:italic true}
                                       :floats :dark
                                       :functions {}
                                       :keywords {:italic true}
                                       :sidebars :dark
                                       :variables {}}
                              :on_colors (fn [colors]
                                           (set colors.bg_statusline (theme-util.darken colors.bg_dark 0.5)))
                              :on_highlights (fn [hl c]
                                               ;folke/tokyonight.nvim repo
                                               (set hl.TelescopeNormal
                                                    {:bg c.bg-dark
                                                     :fg c.fg-dark})
                                               (set hl.TelescopeBorder
                                                    {:bg c.bg-dark
                                                     :fg c.fg-dark})
                                               (set hl.TelescopePromptNormal
                                                    {:bg c.bg-dark})
                                               (set hl.TelescopePromptBorder
                                                    {:bg c.bg-dark
                                                     :fg c.fg-dark})
                                               (set hl.TelescopePromptTitle
                                                    {:bg c.bg-dark
                                                     :fg c.fg-dark})
                                               (set hl.TelescopePreviewTitle
                                                    {:bg c.bg-dark
                                                     :fg c.fg-dark})
                                               (set hl.TelescopeResultsTitle
                                                    {:bg c.bg-dark
                                                     :fg c.fg-dark})
                                               ;Set `fg` to the color you want your window separators to have
                                               (set hl.WinSeparator
                                                    {:fg "#3b4261" 
                                                     :bold true}))
                              :terminal_colors true})
                (vim.cmd "colorscheme tokyonight")))}]

