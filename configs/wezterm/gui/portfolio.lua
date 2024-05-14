local wezterm = require "wezterm"
local mux = wezterm.mux

local M = {}

function M.setup()
	local websiteDir = wezterm.home_dir .. "/Code/portfolio-2024/portfolio-2024-site"
	local cmsDir = wezterm.home_dir .. "/Code/portfolio-2024/portfolio-2024-cms"
	local workspaceName = "Portfolio 2024"

	-- WEB
	-- Web Terminal
	local webTab, webTerminal, window = mux.spawn_window {
		workspace = workspaceName,
		cwd = websiteDir,
	}

	local webEditor = webTerminal:split {
		direction = "Top",
		size = 0.9,
		cwd = websiteDir,
	}
	webTab:set_title "Website"
	webTerminal:send_text "nr dev\n"
	webEditor:send_text "nvim\n"

	-- CMS
	local cmsTab, cmsTerminal, cmsWindow = window:spawn_tab {
		workspace = workspaceName,
		cwd = cmsDir,
	}
	local cmsEditor = cmsTerminal:split {
		direction = "Top",
		size = 0.9,
		cwd = cmsDir,
	}
	cmsTab:set_title "CMS"
	cmsTerminal:send_text "nr dev\n"
	cmsEditor:send_text "nvim\n"

	-- We want to startup in the coding workspace
	webTab:activate()
	mux.set_active_workspace(workspaceName)
end

return M
