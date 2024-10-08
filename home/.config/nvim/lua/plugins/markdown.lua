-- [nfnl] Compiled from fnl/plugins/markdown.fnl by https://github.com/Olical/nfnl, do not edit.
package.path = (package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua")
package.path = (package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua")
return {{"MeanderingProgrammer/render-markdown.nvim", ft = "markdown", config = true, dependencies = {"nvim-treesitter/nvim-treesitter"}}, {"3rd/image.nvim", ft = "markdown", opts = {integrations = {markdown = {only_render_image_at_cursor = true}}}, config = true}}
