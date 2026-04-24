-- Close tabpages when their last non-NvimTree buffer is removed

local function is_nvim_tree_buffer(bufnr)
  local name = vim.fn.bufname(bufnr)
  if name == "" then return false end
  return name:match("NvimTree_%d*$") ~= nil
end

local function has_non_nvim_tree_buffer(tabpage)
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
    local bufnr = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_is_valid(bufnr) then
      local name = vim.fn.bufname(bufnr)
      local buflisted = vim.api.nvim_buf_get_option(bufnr, 'buflisted')
      if not is_nvim_tree_buffer(bufnr) and (buflisted or name ~= "") then
        return true
      end
    end
  end
  return false
end

local function close_tab_if_needed(tabpage)
  if not vim.api.nvim_tabpage_is_valid(tabpage) then return end
  if has_non_nvim_tree_buffer(tabpage) then return end
  if #vim.api.nvim_list_tabpages() <= 1 then return end
  vim.schedule(function()
    if vim.api.nvim_tabpage_is_valid(tabpage) then
      pcall(vim.api.nvim_set_current_tabpage, tabpage)
      pcall(vim.cmd, 'tabclose')
    end
  end)
end

vim.api.nvim_create_autocmd({'BufDelete'}, {
  callback = function(opts)
    local bufnr = opts.buf or tonumber(vim.fn.expand('<abuf>'))
    if not bufnr then return end
    local info = vim.fn.getbufinfo(bufnr)[1]
    if not info or not info.windows then return end
    for _, win in ipairs(info.windows) do
      local ok, tabpage = pcall(vim.api.nvim_win_get_tabpage, win)
      if ok then close_tab_if_needed(tabpage) end
    end
  end,
  nested = true,
})

vim.api.nvim_create_autocmd({'WinClosed'}, {
  callback = function()
    local winnr = tonumber(vim.fn.expand('<amatch>'))
    if not winnr then return end
    local ok, tabpage = pcall(vim.api.nvim_win_get_tabpage, winnr)
    if not ok then return end
    vim.schedule(function() close_tab_if_needed(tabpage) end)
  end,
  nested = true,
})
