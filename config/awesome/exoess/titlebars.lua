pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

local helpers = require("helpers")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- {{{ Titlebars
local function titlebarbtn(c, color_focus, color_unfocus, shp)
	local ico = wibox.widget {
		markup = '',
		widget = wibox.widget.textbox
	}
	local tb = wibox.widget {
		ico,
		forced_width = dpi(16),
			forced_height = dpi(4),
			bg = color_focus .. 80,
			shape = sqr,
			widget = wibox.container.background
	}

	local function update()
		if client.focus == c then
				tb.bg = color_focus
		else
				tb.bg = color_unfocus
		end
	end
	update()

	c:connect_signal('focus', update)
	c:connect_signal('unfocus', update)

	tb:connect_signal('mouse::enter', function()
		local clr = client.focus ~= c and color_focus or color_focus .. 55
		tb.bg = clr
	end)
	tb:connect_signal('mouse::leave', function()
		local clr = client.focus == c and color_focus or color_unfocus
		tb.bg = clr
	end)

	tb.visible = true
	return tb
end

client.connect_signal('request::titlebars', function(c)
	if c.requests_no_titlebar then
		return
	end

	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal('request::activate', 'titlebar', {raise = true})
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal('request::activate', 'titlebar', {raise = true})
			awful.mouse.client.resize(c)
		end)
	)

	local close = titlebarbtn(c, '#E96379', beautiful.xcolor8 .. 55, gears.shape.circle)
	close:connect_signal('button::press', function()
		c:kill()
	end)

	local minimize = titlebarbtn(c, '#E7DE79', beautiful.xcolor8 .. 55, gears.shape.circle)
	minimize:connect_signal('button::press', function()
		c.minimized = true
	end)

	local maximize = titlebarbtn(c, '#67E480', beautiful.xcolor8 .. 55, gears.shape.circle)
	maximize:connect_signal('button::press', function()
		helpers.maximize(c)
	end)

	awful.titlebar(c, {size = dpi(4)}): setup {
		layout = wibox.layout.align.horizontal,
		{
			{
				close,
				minimize,
				maximize,
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(0),
			},
			left = dpi(0),
			widget = wibox.container.margin,
		},
		{
			{
				layout = wibox.layout.flex.horizontal,
				spacing = beautiful.wibar_spacing
			},
			left = beautiful.wibar_spacing,
			right = beautiful.wibar_spacing,
			widget = wibox.container.margin,
			buttons = buttons,
		},
		{
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = beautiful.wibar_spacing,
			},
			left = beautiful.wibar_spacing,
			right = beautiful.wibar_spacing,
			widget = wibox.container.margin,
			buttons = buttons,
		}
	}
end)
-- }}}
