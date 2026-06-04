vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local lazy_init = lazypath .. "/lua/lazy/init.lua"

if not vim.uv.fs_stat(lazy_init) then
  local repo = "https://github.com/folke/lazy.nvim.git"

  if vim.uv.fs_stat(lazypath) then
    vim.fn.delete(lazypath, "rf")
  end

  local out = vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
  if vim.v.shell_error ~= 0 then
    error("Failed to clone lazy.nvim:\n" .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
local base46_defaults = vim.g.base46_cache .. "defaults"
local base46_statusline = vim.g.base46_cache .. "statusline"

if not (vim.uv.fs_stat(base46_defaults) and vim.uv.fs_stat(base46_statusline)) then
  require("base46").compile()
end

dofile(base46_defaults)
dofile(base46_statusline)

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
