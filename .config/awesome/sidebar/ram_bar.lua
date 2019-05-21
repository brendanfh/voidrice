local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local naughty = require "naughty"

local dpi = xresources.apply_dpi

local max_mem_io = io.popen("free -m --si | awk '/^Mem:/ { print $2 }'")
local max_mem = max_mem_io:read("*n")

local ram_bar = wibox.widget {
	max_value = max_mem,
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

local function update_ram_bar(mem)
	ram_bar.value = tonumber(mem)
end

awful.widget.watch(
	[[ bash -c "
		 free -m --si | awk '/^Mem:/ { print $3 }'
	   "
	]],
	3,
	function(widget, stdout)
		-- Strip whitespace
		-- stdout = string.gsub(stdout, '^%s*(.-)%s*$', '%1')
		update_ram_bar(stdout)
	end
)

return ram_bar
