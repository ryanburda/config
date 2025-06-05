local T = {}

T.lsp_diagnostics = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local error_count = vim.diagnostic.count(bufnr, {severity = vim.diagnostic.severity.ERROR})[0]
  if error_count == nil then
    error_count = 0
  end

  local warning_count = vim.diagnostic.count(bufnr, {severity = vim.diagnostic.severity.WARN})[0]
  if warning_count == nil then
    warning_count = 0
  end

  return string.format('E:%d W:%d', error_count, warning_count)
end

T.git_branch = function()
    -- This command gets the current git branch name
    local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
    local branch = handle:read("*a"):match("^%s*(.-)%s*$") -- Trim whitespace
    handle:close()

    -- Update the global variable
    if branch and branch ~= "" then
        vim.g.current_git_branch = branch
    else
        vim.g.current_git_branch = ''
    end
end

T.git_status_is_dirty = function()
  -- Run 'git status --porcelain' in the current directory
  local handle = io.popen("git status --porcelain 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  -- If result is not empty, there are uncommitted changes
  if result ~= "" then
    vim.g.git_status_is_dirty = '[+]'
  else
    vim.g.git_status_is_dirty = ''
  end
end

T.setup = function()

  -- Git branch global variable.
  local update_git_branch_group = vim.api.nvim_create_augroup("UpdateGitBranch", { clear = true })
  vim.api.nvim_create_autocmd({"FocusGained", "BufWritePre", "BufWinEnter", "BufReadPost"}, {
    group = update_git_branch_group,
    callback = T.git_branch
  })

  -- Git status is dirty.
  local git_status_is_dirty_group = vim.api.nvim_create_augroup("GitStatusIsDirty", { clear = true })
  vim.api.nvim_create_autocmd({"FocusGained", "BufWritePre", "BufWinEnter", "BufReadPost"} , {
    group = git_status_is_dirty_group,
    callback = T.git_status_is_dirty
  })

end

T.get_git_branch = function()
  if vim.g.current_git_branch then
    return vim.g.current_git_branch
  else
    return ""
  end
end

T.get_git_status_is_dirty = function()
  if vim.g.git_status_is_dirty then
    return vim.g.git_status_is_dirty
  else
    return ""
  end
end


return T
