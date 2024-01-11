local wezterm = require("wezterm")
local mux = wezterm.mux

local M = {}

local function setup_tab(window, workspaceName, title, config)
	local tab, terminal
	if window then
		tab, terminal = window:spawn_tab({ workspace = workspaceName, cwd = config.dir })
	else
		tab, terminal, window = mux.spawn_window({ workspace = workspaceName, cwd = config.dir })
	end

	local editor = terminal:split({
		direction = "Top",
		size = 0.9,
		cwd = config.dir,
	})
	tab:set_title(title)
	terminal:send_text(config.terminal_command .. "\n")
	editor:send_text(config.editor_command .. "\n")
	return tab, window
end

function M.setup()
	local projects = {
		{
			title = "Website",
			config = {
				dir = wezterm.home_dir .. "/Code/amazentis/timeline-website",
				terminal_command = "nr dev",
				editor_command = "nvim",
			},
		},
		{
			title = "CMS",
			config = {
				dir = wezterm.home_dir .. "/Code/amazentis/timeline-cms",
				terminal_command = "nr dev",
				editor_command = "nvim",
			},
		},

		{
			title = "Wordle",
			config = {
				dir = wezterm.home_dir .. "/Code/amazentis/timeline-wordle",
				terminal_command = "nr dev",
				editor_command = "nvim",
			},
		},
		{
			title = "Components",
			config = {
				dir = wezterm.home_dir .. "/Code/amazentis/timeline-components",
				terminal_command = "ns",
				editor_command = "nvim",
			},
		},
	}

	local workspaceName = "timeline"
	local firstTab
	local window

	for _, project in ipairs(projects) do
		local tab
		if firstTab == nil then
			firstTab, window = setup_tab(window, workspaceName, project.title, project.config)
		else
			tab, _ = setup_tab(window, workspaceName, project.title, project.config)
		end
	end

	-- We want to startup in the coding workspace
	firstTab:activate()
	mux.set_active_workspace(workspaceName)
end

return M
