require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Fix NvChad tabufline mappings in winfixbuf windows (e.g. leetcode.nvim)
if require("nvconfig").ui.tabufline.enabled then
  local function tabufline_guard(cb)
    return function()
      if vim.wo.winfixbuf then
        vim.notify_once(
          "winfixbuf enabled: buffer switching is disabled in this window (e.g. leetcode.nvim). Use gt/gT or :Leet tabs.",
          vim.log.levels.WARN
        )
        return
      end
      cb()
    end
  end

  map("n", "<tab>", tabufline_guard(function()
    require("nvchad.tabufline").next()
  end), { desc = "buffer goto next" })

  map("n", "<S-tab>", tabufline_guard(function()
    require("nvchad.tabufline").prev()
  end), { desc = "buffer goto prev" })

  map("n", "<leader>x", tabufline_guard(function()
    require("nvchad.tabufline").close_buffer()
  end), { desc = "buffer close" })
end
