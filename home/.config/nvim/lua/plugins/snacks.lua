return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      lazygit = { enabled = true },
      explorer = { enabled = true },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<a-c>"] = { "toggle_cwd", mode = { "n", "i" } },
            },
          },
        },
        actions = {
          ---@param p snacks.Picker
          toggle_cwd = function(p)
            local root = require("root")
            local root_dir = root.get()
            local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
            local current = p:cwd()
            p:set_cwd(current == root_dir and cwd or root_dir)
            p:find()
          end,
        },
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      local root = require("root")

      -- Explorer
      vim.keymap.set("n", "<leader>fe", function()
        Snacks.explorer({ cwd = root.get() })
      end, { desc = "Explorer (root)" })
      vim.keymap.set("n", "<leader>fE", function()
        Snacks.explorer()
      end, { desc = "Explorer (cwd)" })

      -- Top-level
      vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep({ cwd = root.get() }) end, { desc = "Grep (Root Dir)" })
      vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
      vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })

      -- Find
      vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, { desc = "Buffers (all)" })
      vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files({ cwd = root.get() }) end, { desc = "Find Files (Root Dir)" })
      vim.keymap.set("n", "<leader>fF", function() Snacks.picker.files() end, { desc = "Find Files (cwd)" })
      vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Files (git-files)" })
      vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
      vim.keymap.set("n", "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true } }) end, { desc = "Recent (cwd)" })
      vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
      -- Custom: nvim config & dotfiles
      vim.keymap.set("n", "<leader>fn", function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "Find Nvim Config" })
      vim.keymap.set("n", "<leader>fc", function()
        Snacks.picker.files({
          cwd = vim.fn.expand("$HOME/.homesick/repos/dotfiles-castle"),
          hidden = true,
          follow = true,
        })
      end, { desc = "Find Dotfiles Castle" })
      vim.keymap.set("n", "<leader>fC", function()
        Snacks.picker.grep({
          cwd = vim.fn.expand("$HOME/.homesick/repos/dotfiles-castle"),
          hidden = true,
        })
      end, { desc = "Grep Dotfiles Castle" })

      -- Git pickers
      vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (hunks)" })
      vim.keymap.set("n", "<leader>gD", function() Snacks.picker.git_diff({ base = "origin", group = true }) end, { desc = "Git Diff (origin)" })
      vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
      vim.keymap.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
      vim.keymap.set("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
      vim.keymap.set("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
      vim.keymap.set("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
      vim.keymap.set("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub Pull Requests (all)" })
      local function copy_git_link(opts)
        Snacks.gitbrowse(vim.tbl_extend("force", opts or {}, {
          open = function(url)
            vim.fn.setreg("+", url)
            vim.notify("Copied: " .. url)
          end,
        }))
      end
      vim.keymap.set("n", "<leader>gy", function() copy_git_link() end, { desc = "Copy GitHub permalink" })
      vim.keymap.set("v", "<leader>gy", function() copy_git_link() end, { desc = "Copy GitHub permalink (range)" })

      -- Grep
      vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
      vim.keymap.set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
      vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep({ cwd = root.get() }) end, { desc = "Grep (Root Dir)" })
      vim.keymap.set("n", "<leader>sG", function() Snacks.picker.grep() end, { desc = "Grep (cwd)" })
      vim.keymap.set("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "Search Plugin Spec" })
      vim.keymap.set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word({ cwd = root.get() }) end, { desc = "Word/Selection (Root Dir)" })
      vim.keymap.set({ "n", "x" }, "<leader>sW", function() Snacks.picker.grep_word() end, { desc = "Word/Selection (cwd)" })

      -- Search
      vim.keymap.set("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
      vim.keymap.set("n", "<leader>s/", function() Snacks.picker.search_history() end, { desc = "Search History" })
      vim.keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
      vim.keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
      vim.keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
      vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
      vim.keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
      vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
      vim.keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
      vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
      vim.keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
      vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
      vim.keymap.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
      vim.keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
      vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
      vim.keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
      vim.keymap.set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
      vim.keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undotree" })

      -- UI
      vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
    end,
  }
}
