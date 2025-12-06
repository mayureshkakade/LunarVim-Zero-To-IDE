local wezterm = require 'wezterm'
local act = wezterm.action

-- === VISUAL CONFIGURATION ONLY ===
-- (Session management is now handled by tmux inside WSL)

wezterm.on('format-tab-title', function(tab)
  return string.format(' %d ', tab.tab_index + 1)
end)

return {
  default_domain = 'WSL:Ubuntu-22.04',

  -- === BASIC SETTINGS ===
  default_cwd = wezterm.home_dir,

  -- WezTerm treats WSL domains as special.
  -- We rely on the shell configuration (Step 3) to launch tmux.

  keys = {

    -- Utility
    { key = 'Space', mods = 'CTRL|SHIFT', action = act.ActivateCopyMode },
    { key = 'D',     mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay },

  },

  -- === VISUALS ===
  font = wezterm.font_with_fallback({
    { family = 'FiraCode Nerd Font', weight = 'Regular' },
    { family = 'JetBrains Mono',     weight = 'Regular' },
    'Consolas',
  }),
  font_size = 13.5,
  line_height = 1.3,

  window_decorations = "TITLE | RESIZE",
  window_background_opacity = 1.0,
  text_background_opacity = 1.0,

  window_padding = {
    left = 5,
    right = 5,
    top = 0,
    bottom = 0,
  },

  use_fancy_tab_bar = false,
  tab_bar_at_bottom = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_max_width = 16,

  -- === PERFORMANCE ===
  front_end = "WebGpu",
  max_fps = 120,
  webgpu_power_preference = "HighPerformance",
  enable_scroll_bar = false,
  scrollback_lines = 3000,
  default_cursor_style = 'SteadyBlock',
  cursor_blink_rate = 0,

  audible_bell = 'Disabled',
  visual_bell = {
    fade_in_duration_ms = 0,
    fade_out_duration_ms = 0,
    target = 'BackgroundColor',
  },

  enable_kitty_keyboard = true,
  check_for_updates = false,
  alternate_buffer_wheel_scroll_speed = 5,
  window_close_confirmation = 'NeverPrompt',
}
