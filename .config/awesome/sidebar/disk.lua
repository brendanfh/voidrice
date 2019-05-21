local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local naughty = require "naughty"

local disk = wibox.widget {
	text = "",
	font = "SourceCodePro-Medium 16",

	align = "center",
	valign = "center",

	widget = wibox.widget.textbox
}

awful.widget.watch(
	[[
		bash -c "
			df -h /dev/nvme0n1p1 | awk '/[0-9]/ { print $4 }'
		"
	]],
	600,
	function(widget, stdout)
		disk.text = " " .. stdout:sub(1, -2) .. " Free"
	end
)

return disk
