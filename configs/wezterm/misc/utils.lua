local wezterm = require("wezterm")
local process_icons = require("misc/icons")

local M = {}

function M.get_process(tab)
	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

	return wezterm.format((process_icons[process_name] or { { Text = string.format("%s:", process_name) } }))
end

function M.get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	if current_dir == HOME_DIR then
		return "~ "
	end

	return string.gsub(current_dir, "(.*[/\\])(.*)", "%2")
end

function M.tab_title(tab_info)
	local icon = M.get_process(tab_info)
	-- Obtain the tab title
	local title = tab_info.tab_title
	-- Check if the tab title is explicitly set
	if not title or #title == 0 then
		-- If not, use the title from the active pane in that tab
		title = M.get_current_working_dir(tab_info)
	end
	-- Format and return the final tab title
	return wezterm.format({
		{ Text = "  " },
		{ Foreground = { AnsiColor = "Blue" } },
		{ Text = icon },
		{ Text = "  " },
		{ Foreground = { AnsiColor = "Silver" } },
		{ Text = title },
		{ Text = "  " },
		"ResetAttributes",
	})
	-- return string.format(" %s  %s ", icon, title)
end

return M
