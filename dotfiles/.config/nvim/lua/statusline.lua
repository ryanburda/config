local T = {}

T.lsp_diagnostics = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local error_count = vim.lsp.diagnostic.get_count(bufnr, "Error")
  local warning_count = vim.lsp.diagnostic.get_count(bufnr, "Warning")
  return string.format('E:%d W:%d', error_count, warning_count)
end

T.git_branch = function()
  -- Run the 'git branch --show-current' command to get the current branch name
  local branch = vim.fn.system('git -C ' .. vim.fn.expand('%:p:h') .. ' rev-parse --abbrev-ref HEAD'):gsub("%s+", "")
  -- Check for errors (e.g., not a git repository)
  if vim.v.shell_error ~= 0 then
    branch = '' -- No branch name if error occurs
  end
  return branch
end

T.has_uncommitted_changes = function()
  -- Run 'git status --porcelain' in the current directory
  local handle = io.popen("git status --porcelain 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  -- If result is not empty, there are uncommitted changes
  return result ~= ""
end

T.git_status = function()
  if T.has_uncommitted_changes() then
    return "[+]"
  else
    return ""
  end
end

return T
