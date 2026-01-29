require "nvchad.options"

vim.opt.cmdheight = 1 -- use floating cmdline UIs (e.g. noice.nvim)


-- Use OSC52 clipboard over SSH (copy from remote nvim -> local clipboard).
-- Works well in terminals like Alacritty. If you use tmux, you may need extra tmux config.
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
  if ok then
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = osc52.copy("+"),
        ["*"] = osc52.copy("*"),
      },
      paste = {
        ["+"] = osc52.paste("+"),
        ["*"] = osc52.paste("*"),
      },
    }
    vim.opt.clipboard = "unnamedplus"
  end
end

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
