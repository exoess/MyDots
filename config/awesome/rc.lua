-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
require("exoess.error_handling")
-- }}}

-- {{{ Variable definitions
require("exoess.variable_definitions")
-- }}}

-- {{{ Menu
require("exoess.menu")
-- }}}

-- {{{ Tag layout
require("exoess.tag_layout")
-- }}}

-- {{{ Wallpaper
require("exoess.wallpaper")
-- }}}

-- {{{ Wibar
require("exoess.wibar")
-- }}}

-- {{{ Mouse bindings
require("exoess.mouse_bindings")
-- }}}

-- {{{ Key bindings
require("exoess.key_bindings")
-- }}}

-- {{{ Rules
require("exoess.rules")
-- }}}

-- {{{ Titlebars
require("exoess.titlebars")
-- }}}

-- {{{ Notifications
require("exoess.notifications")
-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
