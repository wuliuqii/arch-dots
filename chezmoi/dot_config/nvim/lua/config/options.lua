-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local function hex_is_light(hex)
  local r, g, b = hex:match("#?(%x%x)(%x%x)(%x%x)")
  if not r then
    return nil
  end

  r = tonumber(r, 16)
  g = tonumber(g, 16)
  b = tonumber(b, 16)

  local luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
  return luminance > 127
end

local function ghostty_background_mode()
  if vim.env.TERM_PROGRAM ~= "ghostty" or vim.fn.executable("ghostty") == 0 then
    return nil
  end

  local out = vim.fn.system({ "ghostty", "+show-config" })
  if vim.v.shell_error ~= 0 then
    return nil
  end

  local bg = out:match("^background%s*=%s*(#%x%x%x%x%x%x)")
    or out:match("\nbackground%s*=%s*(#%x%x%x%x%x%x)")

  if not bg then
    return nil
  end

  return hex_is_light(bg) and "light" or "dark"
end

local function gsettings_background_mode()
  if vim.fn.executable("gsettings") == 0 then
    return nil
  end

  local out = vim.fn.system({ "gsettings", "get", "org.gnome.desktop.interface", "color-scheme" })
  if vim.v.shell_error ~= 0 then
    return nil
  end

  if out:find("prefer-dark", 1, true) then
    return "dark"
  end

  if out:find("default", 1, true) or out:find("prefer-light", 1, true) then
    return "light"
  end

  return nil
end

local function preferred_background_mode()
  return gsettings_background_mode() or ghostty_background_mode()
end

local function sync_background()
  local bg = preferred_background_mode()
  if bg and vim.o.background ~= bg then
    vim.o.background = bg
  end
end

local function sync_catppuccin_variant()
  local target = vim.o.background == "light" and "catppuccin-latte" or "catppuccin-macchiato"
  local current = vim.g.colors_name

  if current == target then
    return
  end

  if current and current:find("^catppuccin") then
    pcall(vim.cmd.colorscheme, target)
  end
end

sync_background()

vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "FocusGained", "ColorScheme" }, {
  callback = function()
    vim.schedule(function()
      sync_background()
      sync_catppuccin_variant()
    end)
  end,
})

-- disable mouse
vim.opt.mouse = ""
vim.opt.spell = true
vim.opt.spelllang = { "en_us", "cjk" }
