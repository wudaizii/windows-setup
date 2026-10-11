-- ============================================
-- WezTerm 终端配置
-- 放置路径: $HOME/.wezterm.lua
-- 参考: https://wezfurlong.org/wezterm/
-- ============================================

local wezterm = require 'wezterm'

return {
    -- 字体
    font = wezterm.font_with_fallback {
        'JetBrainsMono Nerd Font',
        'Microsoft YaHei UI',
    },
    font_size = 13.0,

    -- 配色（Catppuccin Mocha）
    color_scheme = 'Catppuccin Mocha',

    -- 窗口
    window_background_opacity = 0.92,
    window_decorations = 'RESIZE',
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = false,

    -- 默认启动 PowerShell 7
    default_prog = { 'pwsh.exe' },

    -- 键位
    keys = {
        { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = 'd', mods = 'CTRL|ALT', action = wezterm.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.CloseCurrentPane { confirm = true } },
        { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.ActivatePaneDirection 'Left' },
        { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.ActivatePaneDirection 'Right' },
        { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.ActivatePaneDirection 'Up' },
        { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.ActivatePaneDirection 'Down' },
    },

    -- GPU 加速
    front_end = 'WebGpu',
}