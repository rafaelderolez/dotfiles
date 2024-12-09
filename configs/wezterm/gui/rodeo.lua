local wezterm = require "wezterm"
local mux = wezterm.mux

local M = {}

local function setup_editor_tab(window, workspaceName, dir)
	local tab, terminal, window_ret
	if window then
		tab, terminal = window:spawn_tab {
			workspace = workspaceName,
			cwd = dir,
		}
	else
		tab, terminal, window_ret = mux.spawn_window {
			workspace = workspaceName,
			cwd = dir,
		}
	end

	terminal:send_text "nvim\n"
	tab:set_title "Editor"
	return tab, window_ret or window
end

local function setup_dev_tab(window, workspaceName, dir)
	local tab, terminal = window:spawn_tab {
		workspace = workspaceName,
		cwd = dir,
	}

	-- First pane: generate && dev
	terminal:send_text "nr generate && nr dev\n"

	-- Second pane: generate:panda-watch
	local panda_pane = terminal:split {
		direction = "Right",
		size = 0.5,
		cwd = dir,
	}
	panda_pane:send_text "nr generate:panda-watch\n"

	-- Third pane: storybook
	local storybook_pane = terminal:split {
		direction = "Bottom",
		size = 0.5,
		cwd = dir,
	}
	storybook_pane:send_text "nr storybook\n"

	-- Fourth pane: empty
	local empty_pane = panda_pane:split {
		direction = "Bottom",
		size = 0.5,
		cwd = dir,
	}

	tab:set_title "Dev"
	return tab
end

function M.setup()
	local workspaceName = "rodeo"
	local projectDir = wezterm.home_dir .. "/Code/fnd/fnd-frontend/apps/electric"

	-- Create first tab with editor
	local firstTab, window = setup_editor_tab(nil, workspaceName, projectDir)

	-- Create second tab with 4-way split
	local devTab = setup_dev_tab(window, workspaceName, projectDir)

	-- Activate first tab and set workspace
	firstTab:activate()
	mux.set_active_workspace(workspaceName)
end

return M
