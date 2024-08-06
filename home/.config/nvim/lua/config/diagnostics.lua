-- [nfnl] Compiled from fnl/config/diagnostics.fnl by https://github.com/Olical/nfnl, do not edit.
local conf = {settings = {underline = {default = false}, virtual_text = {default = false}, signs = {default = false}, update_in_insert = {default = false}, all = false, start_on = false}}
local function turn_off_diagnostics_buffer()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, conf.settings)
  local clients = vim.lsp.get_active_clients()
  local show_fn
  local function _1_(b, c, conf0)
    for ns, _ in pairs(vim.diagnostic.get_namespaces()) do
      vim.diagnostic.show(ns, b, nil, conf0)
    end
    return nil
  end
  show_fn = _1_
  for client_id, _ in pairs(clients) do
    local buffers = vim.lsp.get_buffers_by_client_id(client_id)
    for _0, buffer_id in ipairs(buffers) do
      show_fn(buffer_id, client_id, conf.settings)
    end
  end
  return nil
end
--[[ (vim.lsp.get_active_clients) (each [_ buffer_id (ipairs (vim.lsp.get_buffers_by_client_id 1))] (print buffer_id conf.settings)) (print conf.settings) (print (. conf "settings")) (vim.diagnostic.get_namespaces) (vim.diagnostic.show 34 1 nil conf.settings) (vim.notify "hello!!!" vim.log.levels.INFO) (let [lsp-diagnostic (require "vim.lsp.diagnostic")] (lsp-diagnostic.display nil 1 1 conf.settings)) (print (vim.inspect vim)) (vim.diagnostic.hide 34 1) ]]
local function _2_()
  return print("works!!!")
end
return {["turn-off-diagnostics-buffer"] = turn_off_diagnostics_buffer, t = _2_}
