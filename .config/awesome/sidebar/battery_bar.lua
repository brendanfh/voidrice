local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local naughty = require "naughty"

local dpi = xresources.apply_dpi
local BAT = "BAT0"

local battery_bar = wibox.widget {
	max_value = 100,
	value = 50,

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

local function update_battery_bar(battery_percent)
	battery_bar.value = tonumber(battery_percent)
end

awful.widget.watch(
	[[ bash -c "
		cat /sys/class/power_supply/]] .. BAT .. [[/capacity
	   "
	]],
	30,
	function(widget, stdout)
		-- Strip whitespace
		-- stdout = string.gsub(stdout, '^%s*(.-)%s*$', '%1')
		update_battery_bar(stdout)
	end
)

return battery_bar
