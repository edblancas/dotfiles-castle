(set package.path (.. package.path ";" (vim.fn.expand "$HOME") "/.luarocks/share/lua/5.1/?/init.lua"))
(set package.path (.. package.path ";" (vim.fn.expand "$HOME") "/.luarocks/share/lua/5.1/?.lua"))

[{1 :MeanderingProgrammer/render-markdown.nvim
    :ft :markdown
    :config true
    :dependencies [:nvim-treesitter/nvim-treesitter]
    :opts {:sign {:enabled false}}}
 {1 :3rd/image.nvim
    :ft :markdown
    :opts {:integrations {:markdown {:only_render_image_at_cursor true}}}
    :config true}]
