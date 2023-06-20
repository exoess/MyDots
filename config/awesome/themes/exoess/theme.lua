---------------------------
-- Exoess awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir().."themes/"

local theme = {}

theme.font = "jetbrainsmononerdfont 8"

theme.xfg = xrdb.foreground or "#E1E1E6"
theme.xbg = xrdb.background or "#191622"

theme.xcolor0 = xrdb.color0 or "#000000"
theme.xcolor1 = xrdb.color1 or "#FF5555"
theme.xcolor2 = xrdb.color2 or "#50FA7B"
theme.xcolor3 = xrdb.color3 or "#EFFA78"
theme.xcolor4 = xrdb.color4 or "#BD93F9"
theme.xcolor5 = xrdb.color5 or "#FF79C6"
theme.xcolor6 = xrdb.color6 or "#8D79BA"
theme.xcolor7 = xrdb.color7 or "#BFBFBF"
theme.xcolor8 = xrdb.color8 or "#4D4D4D"
theme.xcolor9 = xrdb.color9 or "#FF6E67"
theme.xcolor10 = xrdb.color10 or "#5AF78E"
theme.xcolor11 = xrdb.color11 or "#EAF08D"
theme.xcolor12 = xrdb.color12 or "#CAA9FA"
theme.xcolor13 = xrdb.color13 or "#FF92D0"
theme.xcolor14 = xrdb.color14 or "#AA91E3"
theme.xcolor15 = xrdb.color15 or "#E6E6E6"

theme.bg_normal     = "#393939"
theme.bg_focus      = "#606060"
theme.bg_urgent     = "#E96379"
theme.bg_minimize   = "#4D4D4D"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#E1E1E6"
theme.fg_focus      = "#ccccd4"
theme.fg_urgent     = "#ccccd4"
theme.fg_minimize   = "#ccccd4"

theme.useless_gap         = dpi(0)
theme.border_width        = dpi(1)
theme.border_color_normal = "#000000"
theme.border_color_active = "#535d6c"
theme.border_color_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = '\u{25B6}'
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."exoess/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."exoess/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."exoess/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."exoess/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."exoess/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."exoess/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."exoess/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."exoess/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."exoess/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."exoess/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."exoess/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."exoess/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."exoess/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."exoess/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."exoess/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."exoess/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."exoess/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."exoess/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."exoess/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."exoess/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path.."walls/exoess.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."exoess/layouts/fairhw.png"
theme.layout_fairv = themes_path.."exoess/layouts/fairvw.png"
theme.layout_floating  = themes_path.."exoess/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."exoess/layouts/magnifierw.png"
theme.layout_max = themes_path.."exoss/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."exoess/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."exoess/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."exoess/layouts/tileleftw.png"
theme.layout_tile = themes_path.."exoess/layouts/tilew.png"
theme.layout_tiletop = themes_path.."exoess/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."exoess/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."exoess/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."exoess/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."exoess/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."exoess/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."exoess/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus"

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

theme.titlebar_enabled = true
theme.titlebar_size = dpi(8)
theme.titlebar_title_enabled = true
theme.titlebar_title_alight = "center"
theme.titlebar_position = "top"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
