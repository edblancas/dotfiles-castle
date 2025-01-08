return {
  { "christoomey/vim-tmux-navigator" },
  {
    'preservim/vimux',
    keys = {
      {
        "<leader>vp",
        "<cmd>VimuxPromptCommand<CR>",
        desc = "Prompt for a command to run",
        mode = { "n" }
      },
      {
        "<leader>vl",
        "<cmd>VimuxRunLastCommand<CR>",
        desc = "Run last command executed by VimuxRunCommand",
        mode = { "n" }
      },
      {
        "<leader>vi",
        "<cmd>VimuxInspectRunner<CR>",
        desc = "Inspect runner pane",
        mode = { "n" }
      },
      {
        "<leader>vq",
        "<cmd>VimuxCloseRunner<CR>",
        desc = "Close vim tmux runner opened by VimuxRunCommand",
        mode = { "n" }
      },
      {
        "<leader>vx",
        "<cmd>VimuxInterruptRunner<CR>",
        desc = "Interrupt any command running in the runner pane",
        mode = { "n" }
      },
      {
        "<leader>vz",
        ":call VimuxZoomRunner()",
        desc = "Zoom the runner pane (use <bind-key> z to restore runner pane)",
        mode = { "n" }
      },
      {
        "<leader>v<C-l>",
        "<cmd>VimuxClearTerminalScreen<CR>",
        desc = "Clear the terminal screen of the runner pane",
        mode = { "n" }
      },
      {
        "<leader>vm",
        "<cmd>VimuxPromptCommand('make ')<CR>",
        desc = "Prompt for a make command to run",
        mode = { "n" }
      }
    }
  }
}
