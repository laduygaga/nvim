local M = {}

function M.get_capabilities(override)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace = capabilities.workspace or {}
  capabilities.workspace.didChangeWatchedFiles = {
    dynamicRegistration = true,
  }
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end
  if override then
    capabilities = vim.tbl_deep_extend("force", capabilities, override)
  end
  return capabilities
end

return M
