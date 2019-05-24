local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local naughty = require "naughty"

local dpi = xresources.apply_dpi

local API_KEY = "7ab91e65e45e3d9b8f4dfb99708f9171"
local city_id = "5231851"
local units = "imperial"

local weather = wibox.widget {
	text = "Loading...",
	valign = "center",
	align = "center",
	font = "SourceCodePro-Medium 18",
	widget = wibox.widget.textbox,
}

local icons = {
	["01d"] = "";
	["01n"] = "";
	["02d"] = "";
	["02n"] = "";
	["03d"] = "";
	["03n"] = "";
	["04d"] = "";
	["04n"] = "";
	["09d"] = "";
	["09n"] = "";
	["10d"] = "";
	["10n"] = "";
	["11d"] = "";
	["11n"] = "";
	["13d"] = "";
	["13n"] = "";
	["50d"] = "";
	["50n"] = "";
}

local function update_weather(icon, desc)
	local ico = icons[icon]

	weather.text = ico .. " " .. desc:sub(1, 1):upper() .. desc:sub(2)
end

awful.widget.watch(
	[[ bash -c '
		KEY="]] .. API_KEY .. [["		
		UNITS="]] .. units .. [["		
		CITY="]] .. city_id .. [["		

		weather=$(curl -sf "https://api.openweathermap.org/data/2.5/weather?appid=$KEY&units=$UNITS&id=$CITY")

		weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
		weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d'.' -f1)
		weather_desc=$(echo "$weather" | jq -r ".weather[0].description")

		echo $weather_icon $weather_desc $weather_temp°F
	']],
	60 * 20, -- 20 minutes
	function(widget, stdout)
		local icon = stdout:sub(1, 3)
		local description = stdout:sub(5)

		update_weather(icon, description)
	end
)

--[[
			| tee >(jq ".weather[0].icon") \
				  >(jq ".main.temp") \
				  | jq ".weather[0].description"
--]]
return weather
