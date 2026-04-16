local M = {}

-- markers similar to LazyVim defaults
M.root_patterns = {
  ".git",
  "lua",
  "package.json",
  "pyproject.toml",
  "go.mod",
  "Cargo.toml",
  ".hg",
}

-- per-buffer cache
local cache = {}

-- get LSP root
local function get_lsp_root(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if client.config and client.config.root_dir then
      return client.config.root_dir
    end
  end
end

-- get marker root
local function get_pattern_root(bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == "" then
    return nil
  end
  return vim.fs.root(fname, M.root_patterns)
end

function M.get(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if cache[bufnr] and vim.loop.fs_stat(cache[bufnr]) then
    return cache[bufnr]
  end

  -- 1️⃣ LSP root
  local lsp_root = get_lsp_root(bufnr)
  if lsp_root then
    cache[bufnr] = lsp_root
    return lsp_root
  end

  -- 2️⃣ Marker root
  local pattern_root = get_pattern_root(bufnr)
  if pattern_root then
    cache[bufnr] = pattern_root
    return pattern_root
  end

  -- 3️⃣ fallback
  local cwd = vim.loop.cwd()
  cache[bufnr] = cwd
  return cwd
end

-- invalidate cache when LSP attaches
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      cache[args.buf] = nil
    end,
  })

  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(args)
      cache[args.buf] = nil
    end,
  })
end

return M
