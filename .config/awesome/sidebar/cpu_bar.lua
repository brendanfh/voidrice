local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local naughty = require "naughty"

local dpi = xresources.apply_dpi

local cpu_bar = wibox.widget {
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

local function update_cpu_bar(cpu_idle)
	cpu_bar.value = 100 - tonumber(cpu_idle)	
end

awful.widget.watch(
	[[ bash -c "
		vmstat 1 2 | tail -1 | awk '{printf \"%d\", $15}'
	   "
	]],
	5,
	function(widget, stdout)
		-- Strip whitespace
		-- stdout = string.gsub(stdout, '^%s*(.-)%s*$', '%1')
		update_cpu_bar(stdout)
	end
)

return cpu_bar
