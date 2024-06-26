local wezterm = require "wezterm"
local process_icons = require "misc/icons"

local M = {}

function M.get_process(tab)
	-- Check if the foreground_process_name is a string before processing
	local process_name = tab.active_pane.foreground_process_name

	if type(process_name) == "string" then
		-- Only use string.gsub if process_name is a string
		process_name = string.gsub(process_name, "(.*[/\\])(.*)", "%2")
	else
		-- If not a string, default to a placeholder process name
		process_name = "unknown_process"
	end

	-- Return the formatted process name with icons or as plain text
	return wezterm.format((process_icons[process_name] or { { Text = string.format("%s:", process_name) } }))
end

function M.tab_title(tab_info)
	local icon = M.get_process(tab_info)
	-- Obtain the tab title
	local title = tab_info.tab_title
	-- Check if the tab title is explicitly set
	if not title or #title == 0 then
		-- If not, use the title from the active pane in that tab
		title = tab_info.active_pane.title
	end

	-- Format and return the final tab title
	return wezterm.format {
		{ Text = "  " },
		-- { Foreground = { AnsiColor = "Blue" } },
		{ Text = icon },
		{ Text = "  " },
		-- { Foreground = { AnsiColor = "Silver" } },
		{ Text = title },
		"ResetAttributes",
	}
end

return M
