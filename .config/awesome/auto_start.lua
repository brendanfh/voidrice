local awful = require "awful"

auto_start = {
	"compton",
	"nm-applet"
}

for _, app in ipairs(auto_start) do
	awful.spawn(app)
end
