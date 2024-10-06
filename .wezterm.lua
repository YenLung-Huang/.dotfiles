local wezterm = require("wezterm")
local config = {}
-- The color scheme you want to use
local scheme = "Spacemacs (base16)"
-- Obtain the definition of that color scheme
local scheme_def = wezterm.color.get_builtin_schemes()[scheme]

local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

-- Event handlers

-- Better inc/dec font size
wezterm.on("my-inc-font-size", function(window)
	local size = window:effective_config().font_size + 1
	local overrides = window:get_config_overrides() or {}
	overrides.font_size = size
	window:set_config_overrides(overrides)
end)
wezterm.on("my-dec-font-size", function(window)
	local size = window:effective_config().font_size - 1
	local overrides = window:get_config_overrides() or {}
	overrides.font_size = size
	window:set_config_overrides(overrides)
end)

-- Up Right Status
wezterm.on("update-right-status", function(window)
	-- Add font name and size to status bar
	local font = window:effective_config().font.font[1].family
	local size = window:effective_config().font_size
	local status = wezterm.format({
		"ResetAttributes",
		-- { Background = { Color = "#666666" } },
		-- { Foreground = { Color = "White" } },
		{ Text = string.format("%s %spt  ", font, size) },
	})

	-- Add Leader
	local leader = ""
	if window:leader_is_active() then
		leader = "LEADER |"
	end

	window:set_right_status(string.format("%s %s", leader, status))
end)

config.font = wezterm.font("JetBrains Mono")

-- Leader is the same as my old tmux prefix
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = scheme_def.background,
			fg_color = scheme_def.foreground,
		},
	},
}
config.text_blink_rate = 500
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.keys = {
	-- splitting
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "|",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "z",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- rotate panes
	{
		mods = "LEADER",
		key = "Space",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- show the pane selection mode, but have it swap the active and selected panes
	{
		mods = "LEADER",
		key = "0",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),

	{
		mods = "SUPER",
		key = "=",
		action = wezterm.action.EmitEvent("my-inc-font-size"),
	},
	{
		mods = "SUPER",
		key = "-",
		action = wezterm.action.EmitEvent("my-dec-font-size"),
	},
	-- resize panes
	-- split_nav("resize", "h"),
	-- split_nav("resize", "j"),
	-- split_nav("resize", "k"),
	-- split_nav("resize", "l"),
}

return config
