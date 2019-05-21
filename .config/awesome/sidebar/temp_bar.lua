local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local naughty = require "naughty"

local dpi = xresources.apply_dpi

local temp_bar = wibox.widget {
	max_value = 80,
	value = 0,
	min_value = 15,

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

local function update_temp_bar(temp)
	temp_bar.value = tonumber(temp)	
end

awful.widget.watch(
	[[ bash -c "
		sensors 'coretemp-isa-0000' | awk -F'[\:\+°\.]' '/Core 0/ {print $3}' 2>/dev/null
	   "
	]],
	5,
	function(widget, stdout)
		-- Strip whitespace
		-- stdout = string.gsub(stdout, '^%s*(.-)%s*$', '%1')
		update_temp_bar(stdout)
	end
)

return temp_bar
