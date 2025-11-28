local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- === DAEMON MODE SESSION PERSISTENCE ===
-- WezTerm will maintain pane layouts when using mux server (daemon mode)
-- Use `wezterm connect unix` to attach to existing session

-- Set a default workspace name
local WORKSPACE_NAME = 'main'

-- mux-startup fires when the mux server starts (not GUI)
-- Only create initial window here
wezterm.on('mux-startup', function()
  local tab, pane, window = mux.spawn_window {
    workspace = WORKSPACE_NAME,
  }
  mux.set_active_workspace(WORKSPACE_NAME)
end)

-- gui-attached fires when a GUI connects to the mux server
-- This handles both new connections and reconnections
wezterm.on('gui-attached', function(domain)
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      local gui = window:gui_window()
      if gui then
        gui:maximize()
      end
    end
  end
end)

-- Minimal tab formatting - just show tab numbers
wezterm.on('format-tab-title', function(tab)
  return string.format(' %d ', tab.tab_index + 1)
end)

return {
  -- === SESSION PERSISTENCE SETTINGS ===
  default_cwd = wezterm.home_dir,
  default_workspace = WORKSPACE_NAME,

  -- Enable mux server for session persistence
  unix_domains = {
    {
      name = 'unix',
    },
  },

  -- IMPORTANT: This makes `wezterm` command automatically connect to mux server
  default_gui_startup_args = { 'connect', 'unix' },

  keys = {
    { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
    { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
    { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
    { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
    { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
    { key = '6', mods = 'ALT', action = act.ActivateTab(5) },
    { key = '7', mods = 'ALT', action = act.ActivateTab(6) },
    { key = '8', mods = 'ALT', action = act.ActivateTab(7) },
    { key = '9', mods = 'ALT', action = act.ActivateTab(8) },
    {
      key = 'p',
      mods = 'CTRL',
      action = act.ShowTabNavigator,
    },

    -- === WORKSPACE/SESSION MANAGEMENT ===
    -- Show workspace chooser to switch between saved sessions
    {
      key = 'R',
      mods = 'CTRL|SHIFT',
      action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' }
    },

    -- Add split pane shortcuts for more terminal management (avoiding paste conflict)
    { key = 'v',          mods = 'CTRL|ALT',   action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'h',          mods = 'CTRL|ALT',   action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'x',          mods = 'CTRL|SHIFT', action = act.CloseCurrentPane { confirm = true } },

    -- Vim-style pane navigation
    { key = 'h',          mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left' },
    { key = 'j',          mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Down' },
    { key = 'k',          mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Up' },
    { key = 'l',          mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right' },

    -- Pane resizing with arrow keys
    { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },

    -- Copy mode for navigating terminal output with vim keys
    { key = 'Space',      mods = 'CTRL|SHIFT', action = act.ActivateCopyMode },
    { key = 'D',          mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay },
  },

  -- Copy mode key table for vim-style navigation
  key_tables = {
    copy_mode = {
      -- Vim navigation
      { key = 'h', action = act.CopyMode 'MoveLeft' },
      { key = 'j', action = act.CopyMode 'MoveDown' },
      { key = 'k', action = act.CopyMode 'MoveUp' },
      { key = 'l', action = act.CopyMode 'MoveRight' },

      -- Word navigation
      { key = 'w', action = act.CopyMode 'MoveForwardWord' },
      { key = 'b', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'e', action = act.CopyMode 'MoveForwardWordEnd' },

      -- Line navigation
      { key = '0', action = act.CopyMode 'MoveToStartOfLine' },
      { key = '$', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '^', action = act.CopyMode 'MoveToStartOfLineContent' },

      -- Page navigation
      { key = 'g', action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'G', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'u', mods = 'CTRL',                                      action = act.CopyMode 'PageUp' },
      { key = 'd', mods = 'CTRL',                                      action = act.CopyMode 'PageDown' },
      { key = 'b', mods = 'CTRL',                                      action = act.CopyMode 'PageUp' },
      { key = 'f', mods = 'CTRL',                                      action = act.CopyMode 'PageDown' },

      -- Search
      { key = '/', action = act.Search { CaseSensitiveString = '' } },
      { key = 'n', action = act.CopyMode 'NextMatch' },
      { key = 'N', action = act.CopyMode 'PriorMatch' },

      -- Selection and copying
      { key = 'v', action = act.CopyMode { SetSelectionMode = 'Cell' } },
      { key = 'V', action = act.CopyMode { SetSelectionMode = 'Line' } },
      { key = 'v', mods = 'CTRL',                                      action = act.CopyMode { SetSelectionMode = 'Block' } },
      {
        key = 'y',
        action = act.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'Close' }
        }
      },

      -- Exit copy mode
      { key = 'Escape', action = act.CopyMode 'Close' },
      { key = 'i',      action = act.CopyMode 'Close' },
      { key = 'c',      mods = 'CTRL',                action = act.CopyMode 'Close' },
    },
  },

  -- === ULTRA SLEEK APPEARANCE SETTINGS ===
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
  window_decorations = "NONE",
  window_background_opacity = 1.0,
  text_background_opacity = 1.0,
  window_background_gradient = nil,
  -- window_background_gradient = {
  --   colors = { '#0d1117', '#161b22', '#21262d' },
  --   orientation = { Linear = { angle = -45.0 } },
  --   interpolation = 'CatmullRom',
  --   blend = 'Rgb',
  --   noise = 24,
  -- },

  macos_window_background_blur = 0,

  window_padding = {
    left = 12,
    right = 12,
    top = 8,
    bottom = 12,
  },

  window_frame = {
    border_left_width = '0px',
    border_right_width = '0px',
    border_bottom_height = '0px',
    border_top_height = '0px',
  },

  -- === MINIMAL TAB BAR ===
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = false,
  hide_tab_bar_if_only_one_tab = false,
  tab_max_width = 16,

  -- Minimal tab styling
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
      background = 'rgba(13, 17, 23, 0.5)',

      active_tab = {
        bg_color = '#58a6ff',
        fg_color = '#0d1117',
        intensity = 'Bold',
      },

      inactive_tab = {
        bg_color = 'rgba(33, 38, 45, 0.3)',
        fg_color = '#6e7681',
        italic = false,
      },

      inactive_tab_hover = {
        bg_color = 'rgba(48, 54, 61, 0.5)',
        fg_color = '#c9d1d9',
        italic = false,
      },

      new_tab = {
        bg_color = 'rgba(33, 38, 45, 0.3)',
        fg_color = '#6e7681',
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
  animation_fps = 60,
  max_fps = 60,
  scrollback_lines = 5000,
  front_end = "WebGpu",

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
  default_cursor_style = 'SteadyBlock',
  cursor_blink_rate = 0,
  cursor_blink_ease_in = 'Ease',
  cursor_blink_ease_out = 'Ease',

  audible_bell = 'Disabled',
  visual_bell = {
    fade_in_duration_ms = 0,
    fade_out_duration_ms = 0,
    target = 'BackgroundColor',
  },

  enable_kitty_keyboard = true,
  enable_csi_u_key_encoding = false,

  adjust_window_size_when_changing_font_size = false,
  automatically_reload_config = true,
  check_for_updates = false,
  use_ime = true,

  alternate_buffer_wheel_scroll_speed = 3,
  bypass_mouse_reporting_modifiers = "SHIFT",

  initial_cols = 120,
  initial_rows = 32,
  window_close_confirmation = 'NeverPrompt',

  bold_brightens_ansi_colors = true,
  force_reverse_video_cursor = false,

  hyperlink_rules = {
    {
      regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },
  },
}
