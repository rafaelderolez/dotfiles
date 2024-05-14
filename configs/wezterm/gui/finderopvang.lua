local wezterm = require("wezterm")
local mux = wezterm.mux

local M = {}

function M.setup()
	local projectDir = wezterm.home_dir .. "/Code/finderopvang"
	local workspaceName = "Finderopvang"

	-- WEB
	-- Web Terminal
	local tab, terminal, window = mux.spawn_window({
		workspace = workspaceName,
		cwd = projectDir,
	})

	local editor = terminal:split({
		direction = "Top",
		size = 0.9,
		cwd = projectDir,
	})

	local db = terminal:split({
		direction = "Right",
		size = 0.5,
		cwd = projectDir,
	})

	tab:set_title("Finderopvang")
	terminal:send_text("nr dev\n")
	editor:send_text("nvim\n")
	db:send_text("nr db:studio\n")

	-- We want to startup in the coding workspace
	tab:activate()
	mux.set_active_workspace(workspaceName)
end

return M
