local awful 	= require("awful")
local gears 	= require("gears")
local beautiful = require("beautiful")
local wibox		= require("wibox")

local helpers = {}

helpers.rounded_rect = function(radius)
	return function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, radius)
	end
end

helpers.partially_rounded_rect = function(radius, tl, tr, bl, br)
	return function(cr, width, height)
		gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
	end
end

helpers.pad = function(size)
	local str = ""
	for i = 1, size do
		str = str .. " "
	end
	return wibox.widget.textbox(str)
end

return helpers
