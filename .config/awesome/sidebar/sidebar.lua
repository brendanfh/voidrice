local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local naughty = require "naughty"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"

local helpers = require "helpers"

local dpi = xresources.apply_dpi

local time = wibox.widget.textclock("%H:%M")
time.align = "center"
time.valign = "center"
time.font = "SourceCodePro-Bold 48"

local date = wibox.widget.textclock("%A, %B %d")
date.align = "center"
date.valign = "center"
date.font = "SourceCodePro-Medium 18"

local calendar = wibox.widget {
	date = os.date("*t"),
	font = "SourceCodePro-Medium 14",
	start_sunday = true,
	align = "center",
	widget = wibox.widget.calendar.month
}

local weather = require "sidebar.weather"

local cpu_bar = require "sidebar.cpu_bar"
local cpu = wibox.widget {
	nil,
	{
		wibox.widget {
			markup = " ";
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox
		},
		cpu_bar,
		layout = wibox.layout.fixed.horizontal
	},
	nil,
	expand = "none",
	layout = wibox.layout.align.horizontal,
}
cpu:buttons(gears.table.join(
	awful.button(
		{ }, 1,
		function()
			awful.spawn(terminal .. " -e htop")
		end
	)
))

local battery_bar = require "sidebar.battery_bar"
local battery = wibox.widget {
	nil,
	{
		wibox.widget {
			markup = " ",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox
		},
		battery_bar,
		layout = wibox.layout.fixed.horizontal
	},
	nil,
	expand = "none",
	layout = wibox.layout.align.horizontal,
}
battery:buttons(gears.table.join(
	awful.button(
		{ }, 1,
		function()
			local batstat_io = io.popen("acpi")
			local batstat = batstat_io:read("*a"):sub(1, -2)

			naughty.notify {
				title = "Battery status",
				text = batstat
			}
		end
	)
))

local ram_bar = require "sidebar.ram_bar"
local ram = wibox.widget {
	nil,
	{
		wibox.widget {
			markup = " ",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox
		},
		ram_bar,
		layout = wibox.layout.fixed.horizontal
	},
	nil,
	expand = "none",
	layout = wibox.layout.align.horizontal,
}
ram:buttons(gears.table.join(
	awful.button(
		{ }, 1,
		function()
			awful.spawn(terminal .. " -e htop")
		end
	)
))

local temp_bar = require "sidebar.temp_bar"
local temp = wibox.widget {
	nil,
	{
		wibox.widget {
			markup = "   ",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox
		},
		temp_bar,
		layout = wibox.layout.fixed.horizontal
	},
	nil,
	expand = "none",
	layout = wibox.layout.align.horizontal,
}

local volume_bar = require "sidebar.volume_bar"
local volume = wibox.widget {
	nil,
	{
		wibox.widget {
			markup = " ",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox
		},
		volume_bar,
		layout = wibox.layout.fixed.horizontal
	},
	nil,
	expand = "none",
	layout = wibox.layout.align.horizontal,
}
volume:buttons(gears.table.join(
	awful.button(
		{ }, 1,
		function()
			awful.spawn("pamixer --toggle-mute")
			volume_bar.timer:emit_signal "timeout"
		end
	),
	
	awful.button(
		{ }, 3,
		function()
			awful.spawn("pavucontrol")
			volume_bar.timer:emit_signal "timeout"
		end
	),
	
	awful.button(
		{ }, 4,
		function()
			awful.spawn("pamixer -i 5")
			volume_bar.timer:emit_signal "timeout"
		end
	),

	awful.button(
		{ }, 5,
		function()
			awful.spawn("pamixer -d 5")
			volume_bar.timer:emit_signal "timeout"
		end
	)
))

local brightness_bar = require "sidebar.brightness_bar"
local brightness = wibox.widget {
	nil,
	{
		wibox.widget {
			markup = " ",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox
		},
		brightness_bar,
		layout = wibox.layout.fixed.horizontal
	},
	nil,
	expand = "none",
	layout = wibox.layout.align.horizontal,
}
brightness:buttons(gears.table.join(
	awful.button(
		{ }, 4,
		function()
			awful.spawn("xbacklight -inc 5")
			brightness_bar.timer:emit_signal "timeout"
		end
	),

	awful.button(
		{ }, 5,
		function()
			awful.spawn("xbacklight -dec 5")
			brightness_bar.timer:emit_signal "timeout"
		end
	)
))

local disk = require "sidebar.disk"


-- Create the sidebar
local sidebar = wibox {
	x = 0,
	y = 0,
	visible = false,
	ontop = true,
	type = "dock"
}
sidebar.bg = beautiful.bg_normal
sidebar.fg = beautiful.fg_normal
sidebar.opacity = .9
sidebar.height = awful.screen.focused().geometry.height - 0
sidebar.width = dpi(400)

sidebar.radius = beautiful.sidebar_radius or 8
if sidebar.radius > 0 and beautiful.sidebar_position == "right" then
	sidebar.x = awful.screen.focused().geometry.width - sidebar.width
	sidebar.shape = helpers.partially_rounded_rect(sidebar.radius, true, false, true, false)
else
	sidebar.shape = helpers.partially_rounded_rect(sidebar.radius, false, true, false, true)
end

sidebar:buttons(gears.table.join(
	awful.button(
		{ }, 2,
		function()
			sidebar.visible = false
		end
	),

	awful.button(
		{ }, 3,
		function()
			sidebar.visible = false
		end
	)
))

-- Hide sidebar automatically
-- sidebar:connect_signal(
-- 	"mouse::leave",
-- 	function()
-- 		sidebar.visible = false
-- 	end
-- )

local sidebar_activator = wibox {
	y = 0,
	width = 1,
	visible = true,
	ontop = false,
	opacity = 0,
	below = true
}
sidebar_activator.height = awful.screen.focused().geometry.height

if beautiful.sidebar_position == "right" then
	sidebar_activator.x = awful.screen.focused().geometry.width - sidebar_activator.width
else
	sidebar_activator.x = 0
end

sidebar_activator:connect_signal(
	"mouse::enter",
	function()
		sidebar.visible = true
	end
)

sidebar:setup {
	{ 
		helpers.pad(1),
		helpers.pad(1),
		helpers.pad(1),
		helpers.pad(1),
		time,
		helpers.pad(1),
		date,
		helpers.pad(1),
		weather,
		helpers.pad(1),
		{
			wibox.container.margin(calendar, 75, 75),
			layout = wibox.layout.fixed.horizontal
		},
		helpers.pad(1),
		layout = wibox.layout.fixed.vertical
	},
	{
		volume,
		battery,
		cpu,
		ram,
		temp,
		brightness,
		helpers.pad(1),
		disk,
		layout = wibox.layout.fixed.vertical
	},
	{ layout = wibox.layout.fixed.vertical },

	layout = wibox.layout.align.vertical
}

return sidebar
