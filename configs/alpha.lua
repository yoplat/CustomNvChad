local dashboard = require "alpha.themes.dashboard"
local logo = {
  [[=================     ===============     ===============   ========  ========]],
  [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
  [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
  [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
  [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
  [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
  [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
  [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
  [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
  [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
  [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
  [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
  [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
  [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
  [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
  [[||.=='    _-'                                                     `' |  /==.||]],
  [[=='    _-'                        N E O V I M                         \/   `==]],
  [[\   _-'                                                                `-_   /]],
  [[`''                                                                      ``'  ]],
}

local create_gradient = function(start, finish, steps)
  local r1, g1, b1 =
    tonumber("0x" .. start:sub(2, 3)), tonumber("0x" .. start:sub(4, 5)), tonumber("0x" .. start:sub(6, 7))
  local r2, g2, b2 =
    tonumber("0x" .. finish:sub(2, 3)), tonumber("0x" .. finish:sub(4, 5)), tonumber("0x" .. finish:sub(6, 7))

  local r_step = (r2 - r1) / steps
  local g_step = (g2 - g1) / steps
  local b_step = (b2 - b1) / steps

  local gradient = {}
  for i = 1, steps do
    local r = math.floor(r1 + r_step * i)
    local g = math.floor(g1 + g_step * i)
    local b = math.floor(b1 + b_step * i)
    table.insert(gradient, string.format("#%02x%02x%02x", r, g, b))
  end

  return gradient
end

-- Header
local function apply_gradient_hl(text)
  local gradient = create_gradient("#DCA561", "#658594", #text)

  local lines = {}
  for i, line in ipairs(text) do
    local tbl = {
      type = "text",
      val = line,
      opts = {
        hl = "HeaderGradient" .. i,
        shrink_margin = false,
        position = "center",
      },
    }
    table.insert(lines, tbl)

    -- create hl group
    vim.api.nvim_set_hl(0, "HeaderGradient" .. i, { fg = gradient[i] })
  end

  return {
    type = "group",
    val = lines,
    opts = { position = "center" },
  }
end

dashboard.section.buttons.val = {
  dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <CR>"),
  dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <CR>"),
  dashboard.button("w", " " .. " Find text", "<cmd> Telescope live_grep <CR>"),
  dashboard.button("c", " " .. " Config", "<cmd> cd ~/.config/nvim/lua/custom <CR>"),
  dashboard.button("s", " " .. " Restore Session", [[<cmd>lua require("persistence").load({ last = true })<cr>]]),
  dashboard.button("g", " " .. " Git status", "<cmd> Neogit <cr>"),
  dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <CR>"),
  dashboard.button("q", " " .. " Quit", "<cmd> qa <CR>"),
}
for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaText"
  button.opts.hl_shortcut = "AlphaButtons"
end
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"

dashboard.config.layout = {
  { type = "padding", val = 6 },
  apply_gradient_hl(logo),
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  dashboard.section.footer,
}

require("alpha").setup(dashboard.opts)

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dashboard.section.footer.val = "⚡ Neovim loaded "
      .. stats.loaded
      .. "/"
      .. stats.count
      .. " plugins in "
      .. ms
      .. "ms"
    pcall(vim.cmd.AlphaRedraw)
  end,
})
