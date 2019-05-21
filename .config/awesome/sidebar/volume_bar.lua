local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local naughty = require "naughty"

local dpi = xresources.apply_dpi

local volume_bar = wibox.widget {
	max_value = 100,
	value = 20,

	forced_height = dpi(40),
	forced_width = dpi(300),

	margins = {
		top = dpi(8),
		bottom = dpi(8)
	},
	
	shape     = gears.shape.rounded_bar,
	bar_shape = gears.shape.rounded_bar,

	color 			 = beautiful.bg_focus,
	background_color = beautiful.bg_normal,
	border_width 	 = 2,
	border_color 	 = beautiful.bg_focus,

	widget = wibox.widget.progressbar,
}

local function update_volume_bar(vol)
	vol = vol:sub(1, -2)
	if vol == "muted" then
		volume_bar.value = 0
		volume_bar.border_color = "#FF0000"
	else
		volume_bar.value = tonumber(vol:sub(1, -2))
		volume_bar.border_color = beautiful.bg_focus
	end
end

local _, timer = awful.widget.watch(
	[[ bash -c "
		pamixer --get-volume-human
	   "
	]],
	10,
	function(widget, stdout)
		update_volume_bar(stdout)
	end
)

volume_bar.timer = timer

return volume_bar
