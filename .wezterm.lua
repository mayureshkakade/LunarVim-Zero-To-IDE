local wezterm = require 'wezterm'

return {
  keys = {
    { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
    { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
    { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
    { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
    { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
    { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
    { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
    { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
    { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },
    {
      key = 'p',
      mods = 'CTRL',
      action = wezterm.action.ShowTabNavigator,
    },
    -- Add split pane shortcuts for more terminal management (avoiding paste conflict)
    { key = 'v',          mods = 'CTRL|ALT',   action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'h',          mods = 'CTRL|ALT',   action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'x',          mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },

    -- Vim-style pane navigation
    { key = 'h',          mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'j',          mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'k',          mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'l',          mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },

    -- Pane resizing with arrow keys
    { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
    { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
    { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
    { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },

    -- Vim mode in terminal prompt (Ctrl+Space enters vim mode)
    -- { key = 'Space',      mods = 'CTRL',       action = wezterm.action.SendKey { key = 'Escape' } },

    -- Copy mode for navigating terminal output with vim keys
    { key = 'Space',      mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCopyMode },
    { key = 'L',          mods = 'CTRL|SHIFT', action = wezterm.action.ShowDebugOverlay },
  },

  -- Copy mode key table for vim-style navigation
  key_tables = {
    copy_mode = {
      -- Vim navigation
      { key = 'h', action = wezterm.action.CopyMode 'MoveLeft' },
      { key = 'j', action = wezterm.action.CopyMode 'MoveDown' },
      { key = 'k', action = wezterm.action.CopyMode 'MoveUp' },
      { key = 'l', action = wezterm.action.CopyMode 'MoveRight' },

      -- Word navigation
      { key = 'w', action = wezterm.action.CopyMode 'MoveForwardWord' },
      { key = 'b', action = wezterm.action.CopyMode 'MoveBackwardWord' },
      { key = 'e', action = wezterm.action.CopyMode 'MoveForwardWordEnd' },

      -- Line navigation
      { key = '0', action = wezterm.action.CopyMode 'MoveToStartOfLine' },
      { key = '$', action = wezterm.action.CopyMode 'MoveToEndOfLineContent' },
      { key = '^', action = wezterm.action.CopyMode 'MoveToStartOfLineContent' },

      -- Page navigation
      { key = 'g', action = wezterm.action.CopyMode 'MoveToScrollbackTop' },
      { key = 'G', action = wezterm.action.CopyMode 'MoveToScrollbackBottom' },
      { key = 'u', mods = 'CTRL',                                                 action = wezterm.action.CopyMode 'PageUp' },
      { key = 'd', mods = 'CTRL',                                                 action = wezterm.action.CopyMode 'PageDown' },
      { key = 'b', mods = 'CTRL',                                                 action = wezterm.action.CopyMode 'PageUp' },
      { key = 'f', mods = 'CTRL',                                                 action = wezterm.action.CopyMode 'PageDown' },

      -- Search
      { key = '/', action = wezterm.action.Search { CaseSensitiveString = '' } },
      { key = 'n', action = wezterm.action.CopyMode 'NextMatch' },
      { key = 'N', action = wezterm.action.CopyMode 'PriorMatch' },

      -- Selection and copying
      { key = 'v', action = wezterm.action.CopyMode { SetSelectionMode = 'Cell' } },
      { key = 'V', action = wezterm.action.CopyMode { SetSelectionMode = 'Line' } },
      { key = 'v', mods = 'CTRL',                                                 action = wezterm.action.CopyMode { SetSelectionMode = 'Block' } },
      {
        key = 'y',
        action = wezterm.action.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'Close' }
        }
      },

      -- Exit copy mode
      { key = 'Escape', action = wezterm.action.CopyMode 'Close' },
      { key = 'i',      action = wezterm.action.CopyMode 'Close' },
      { key = 'c',      mods = 'CTRL',                           action = wezterm.action.CopyMode 'Close' },
    },
  },

  -- === ULTRA SLEEK APPEARANCE SETTINGS ===
  -- Enhanced color scheme for modern look
  color_scheme = 'Tokyo Night Storm',

  -- Premium font configuration
  font = wezterm.font_with_fallback({
    { family = 'FiraCode Nerd Font', weight = 'Regular' },
    { family = 'JetBrains Mono',     weight = 'Regular' },
    { family = 'Cascadia Code PL',   weight = 'Regular' },
    { family = 'SF Mono',            weight = 'Regular' },
    'Monaco',
  }),
  font_size = 13.5,
  line_height = 1.3,
  cell_width = 1.0,

  -- === PREMIUM WINDOW STYLING ===
  -- Completely remove native title bar for ultra-clean look
  window_decorations = "NONE",

  -- Enhanced window appearance with glass effect
  window_background_opacity = 0.98,
  text_background_opacity = 1.0,

  -- Sophisticated gradient background
  window_background_gradient = {
    colors = { '#0d1117', '#161b22', '#21262d' },
    orientation = { Linear = { angle = -45.0 } },
    interpolation = 'CatmullRom',
    blend = 'Rgb',
    noise = 24,
  },

  -- Enhanced blur for modern glass effect
  macos_window_background_blur = 30,

  -- Refined window padding
  window_padding = {
    left = 12,
    right = 12,
    top = 12,
    bottom = 12,
  },

  -- Window frame styling for borderless look
  window_frame = {
    border_left_width = '0px',
    border_right_width = '0px',
    border_bottom_height = '0px',
    border_top_height = '0px',
  },

  -- === SOPHISTICATED TAB BAR ===
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = false,
  hide_tab_bar_if_only_one_tab = false,
  tab_max_width = 32,

  -- Premium tab styling
  colors = {
    foreground = '#c9d1d9',
    background = '#0d1117',

    cursor_bg = '#58a6ff',
    cursor_fg = '#0d1117',
    cursor_border = '#58a6ff',

    selection_fg = '#0d1117',
    selection_bg = '#58a6ff',

    scrollbar_thumb = '#30363d',

    split = '#21262d',

    ansi = {
      '#484f58', '#ff7b72', '#7ee787', '#d29922',
      '#58a6ff', '#bc8cff', '#39c5cf', '#b1bac4',
    },
    brights = {
      '#6e7681', '#ffa198', '#56d364', '#e3b341',
      '#79c0ff', '#d2a8ff', '#56d4dd', '#f0f6fc',
    },

    tab_bar = {
      background = 'rgba(13, 17, 23, 0.95)',

      active_tab = {
        bg_color = '#58a6ff',
        fg_color = '#0d1117',
        intensity = 'Bold',
      },

      inactive_tab = {
        bg_color = 'rgba(33, 38, 45, 0.8)',
        fg_color = '#8b949e',
        italic = false,
      },

      inactive_tab_hover = {
        bg_color = 'rgba(48, 54, 61, 0.9)',
        fg_color = '#f0f6fc',
        italic = false,
      },

      new_tab = {
        bg_color = 'rgba(33, 38, 45, 0.8)',
        fg_color = '#8b949e',
      },

      new_tab_hover = {
        bg_color = '#58a6ff',
        fg_color = '#0d1117',
      },
    },
  },

  -- === PERFORMANCE & SMOOTHNESS ===
  enable_wayland = false,
  enable_scroll_bar = false,
  animation_fps = 120,
  max_fps = 120,
  scrollback_lines = 10000,
  front_end = "WebGpu",

  -- Optimized WebGPU settings
  webgpu_preferred_adapter = {
    backend = "Vulkan",
    device = 39745,
    device_type = "IntegratedGpu",
    driver = "Intel open-source Mesa driver",
    driver_info = "Mesa 23.2.1-1ubuntu3.1~22.04.3",
    name = "Intel(R) UHD Graphics (CML GT2)",
    vendor = 32902,
  },
  webgpu_power_preference = "HighPerformance",

  -- === PREMIUM USER EXPERIENCE ===
  -- Enhanced cursor with smooth animations
  default_cursor_style = 'BlinkingBlock',
  cursor_blink_rate = 700,
  cursor_blink_ease_in = 'Ease',
  cursor_blink_ease_out = 'Ease',

  -- Refined bell with subtle visual feedback
  audible_bell = 'Disabled',
  visual_bell = {
    fade_in_duration_ms = 100,
    fade_out_duration_ms = 200,
    target = 'BackgroundColor',
  },

  -- Modern input handling
  enable_kitty_keyboard = true,
  enable_csi_u_key_encoding = false,

  -- Additional sleek features
  adjust_window_size_when_changing_font_size = false,
  automatically_reload_config = true,
  check_for_updates = false,
  use_ime = true,

  -- Smooth scrolling configuration
  alternate_buffer_wheel_scroll_speed = 3,
  bypass_mouse_reporting_modifiers = "SHIFT",

  -- Window management
  initial_cols = 120,
  initial_rows = 32,
  window_close_confirmation = 'NeverPrompt',

  -- Advanced rendering
  bold_brightens_ansi_colors = true,
  force_reverse_video_cursor = false,

  -- Hyperlink styling
  hyperlink_rules = {
    -- Linkify things that look like URLs
    {
      regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },
  },
}
