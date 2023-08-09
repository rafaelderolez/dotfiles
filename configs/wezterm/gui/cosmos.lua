local wezterm = require("wezterm")
local mux = wezterm.mux

local M = {}

function M.setup()
	local cosmosWebsiteDir = wezterm.home_dir .. "/Code/cosmos/cosmos-web"
	local cosmosCmsDir = wezterm.home_dir .. "/Code/cosmos/cosmos-studio"
	local workspaceName = "cosmos"

	-- WEB
	-- Web Terminal
	local webTab, webTerminal, window = mux.spawn_window({
		workspace = workspaceName,
		cwd = cosmosWebsiteDir,
	})

	local webEditor = webTerminal:split({
		direction = "Top",
		size = 0.9,
		cwd = cosmosWebsiteDir,
	})
	webTab:set_title("Website")
	webTerminal:send_text("nr dev\n")
	webEditor:send_text("nvim\n")

	-- CMS
	local cmsTab, cmsTerminal, cmsWindow = window:spawn_tab({
		workspace = workspaceName,
		cwd = cosmosCmsDir,
	})
	local cmsEditor = cmsTerminal:split({
		direction = "Top",
		size = 0.9,
		cwd = cosmosCmsDir,
	})
	cmsTab:set_title("CMS")
	cmsTerminal:send_text("nr dev\n")
	cmsEditor:send_text("nvim\n")

	-- We want to startup in the coding workspace
	webTab:activate()
	mux.set_active_workspace(workspaceName)
end

return M
