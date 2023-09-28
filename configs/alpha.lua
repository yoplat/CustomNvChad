local dashboard = require "alpha.themes.dashboard"
local logo = [[
=================     ===============     ===============   ========  ========  
\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //  
||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||  
|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||  
||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||  
|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||  
||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||  
|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||  
||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||  
||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||  
||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||  
||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||  
||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||  
||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||  
||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||  
||.=='    _-'                                                     `' |  /==.||  
=='    _-'                        N E O V I M                         \/   `==  
\   _-'                                                                `-_   /  
`''                                                                      ``'    
]]

dashboard.section.header.val = vim.split(logo, "\n")
dashboard.section.buttons.val = {
  dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
  dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
  dashboard.button("s", " " .. " Restore Session", [[:SessionLoadLast <cr>]]),
  dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
  dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}
for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaText"
  button.opts.hl_shortcut = "AlphaButtons"
end
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.opts.layout[1].val = 5

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
