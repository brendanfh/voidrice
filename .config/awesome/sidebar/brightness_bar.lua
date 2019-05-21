local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local naughty = require "naughty"

local dpi = xresources.apply_dpi

local brightness_bar = wibox.widget {
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

local function update_brightness_bar(bright)
	brightness_bar.value = tonumber(bright)
end

local _, timer = awful.widget.watch(
	[[ bash -c "
		xbacklight | grep -Eo '^[0-9]+'
	   "
	]],
	10,
	function(widget, stdout)
		-- Strip whitespace
		update_brightness_bar(stdout)
	end
)

brightness_bar.timer = timer

return brightness_bar
