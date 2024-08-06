(fn _lazygit_toggle []
  (let [term (require :toggleterm.terminal)
                Terminal term.Terminal
                lazygit (Terminal:new {:cmd :lazygit :hidden true}) ]
    (lazygit:toggle)))

{: _lazygit_toggle}
