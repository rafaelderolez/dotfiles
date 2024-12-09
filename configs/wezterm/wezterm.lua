local wezterm = require "wezterm"
local act = wezterm.action
local cosmosGUI = require "gui/cosmos"
local finderopvangGUI = require "gui/finderopvang"
local portfolioGUI = require "gui/portfolio"
local rodeoGUI = require "gui/rodeo"
local timelineGUI = require "gui/timeline"
local utils = require "misc/utils"

local config = wezterm.config_builder()

local monospace = wezterm.font_with_fallback {
	"GeistMono NF",
	{ family = "Symbols Nerd Font Mono", scale = 0.8 },
}

-- Font
config.font = monospace
config.font_size = 18
config.line_height = 1.3
config.use_cap_height_to_scale_fallback_fonts = true
config.adjust_window_size_when_changing_font_size = false
config.command_palette_font_size = 18
config.command_palette_rows = 16

config.command_palette_bg_color = "#15161F"
config.command_palette_fg_color = "#fff"
config.window_frame = {
	-- font = monospace,
}

-- UI
config.color_scheme = "tokyonight_storm"
config.enable_scroll_bar = false
config.window_decorations = "RESIZE"
config.tab_max_width = 128
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.94
config.macos_window_background_blur = 90
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

-- Keymaps
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Tab navigation
	{ key = "Tab", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },

	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },

	-- Pane Actions
	{
		key = "\\",
		mods = "CTRL",
		action = wezterm.action.SplitPane {
			direction = "Down",
			size = { Percent = 20 },
		},
	},
	{
		key = "|",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane {
			direction = "Right",
			size = { Percent = 50 },
		},
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane { confirm = true },
	},

	-- Toggle current pane visibility
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action_callback(function(_, pane)
			local tab = pane:tab()
			local panes = tab:panes_with_info()
			if #panes == 1 then
				pane:split {
					direction = "Bottom",
					size = 0.3,
				}
			elseif not panes[1].is_zoomed then
				panes[1].pane:activate()
				tab:set_zoomed(true)
			elseif panes[1].is_zoomed then
				tab:set_zoomed(false)
				panes[2].pane:activate()
			end
		end),
	},

	{
		key = "N",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine {
			description = wezterm.format {
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Yellow" } },
				{ Text = "Enter name for new workspace" },
			},
			action = wezterm.action_callback(function(window, pane, line)
				if line then window:perform_action(
					act.SwitchToWorkspace {
						name = line,
					},
					pane
				) end
			end),
		},
	},
}

-- Misc
config.scrollback_lines = 5000
config.check_for_updates = true
config.send_composed_key_when_left_alt_is_pressed = false
config.command_palette_font_size = 17.0
config.default_workspace = "home"
config.unix_domains = {
	{
		name = "timeline",
	},
}

-- Workspaces
wezterm.on("gui-startup", function()
	local project = os.getenv "WZ_PROJECT"

	if project == "timeline" then timelineGUI.setup() end
	if project == "cosmos" then cosmosGUI.setup() end
	if project == "finderopvang" then finderopvangGUI.setup() end
	if project == "portfolio" then portfolioGUI.setup() end
	if project == "rodeo" then rodeoGUI.setup() end
end)

-- Decorate top-right status bar
wezterm.on("update-right-status", function(window)
	-- Workspace name
	local stat = window:active_workspace()

	-- Let's add color to one of the components
	window:set_right_status(wezterm.format {
		{ Foreground = { AnsiColor = "Fuchsia" } },
		{ Text = wezterm.nerdfonts.oct_table .. " " .. stat .. " " },
		"ResetAttributes",
	})
end)

wezterm.on("format-tab-title", function(tab)
	local title = utils.tab_title(tab)
	return {
		{ Text = title },
		{ Text = " " },
	}
end)

return config
