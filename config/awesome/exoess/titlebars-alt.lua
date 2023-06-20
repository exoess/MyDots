local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local abutton = require("awful.button")

local helpers = require("helpers")
local titlebars = {}
local pad = helpers.pad

local capi = {
    client = client
}

awful.titlebar.enable_tooltip = false

local btn_close_color = "#D56C6D"
local btn_close_hover_color = "#d32f2f"

local btn_minimized_color = "#FFF176"
local btn_minimized_hover_color = "#FBC02D"

local btn_maximized_color = "#74DD91"
local btn_maximized_hover_color = "#43A047"

local instances = {}

local function update_on_signal(c, signal, widget)
    local sig_instances = instances[signal]
    if sig_instances == nil then
        sig_instances = setmetatable({}, { __mode = "k" })
        instances[signal] = sig_instances
        capi.client.connect_signal(signal, function(cl)
            local widgets = sig_instances[cl]
            if widgets then
                for _, w in pairs(widgets) do
                    w.update()
                end
            end
        end)
    end
    local widgets = sig_instances[c]
    if widgets == nil then
        widgets = setmetatable({}, { __mode = "v" })
        sig_instances[c] = widgets
    end
    table.insert(widgets, widget)
end

local bar_shape = function(cr, width, height)
  gears.shape.parallelogram(cr, width, height, width-5)
end


function btn(c, name, selector, action, color, hover_color)
    local ret = wibox.widget{
  max_value = 100,
  value = 100,
  forced_width = dpi(30),
  shape = bar_shape,
  bar_shape = bar_shape,
  color = color,
  background_color = color,
  widget = wibox.widget.progressbar,
}

    local function update()
        local img = selector(c)
        local cc = beautiful.color0
        if type(img) ~= "nil" then
            if type(img) == "boolean" then
                if img then
                    img = "active"
                    --cc = hover_color
                else
                    img = "inactive"
                    cc = beautiful.color0
                end
            end
            local prefix = "normal"
            if capi.client.focus == c then
                prefix = "focus"
                cc = color
            end
            if img ~= "" then
                prefix = prefix .. "_"
            end
            local state = ret.state
            if state ~= "" then
                state = "_" .. state
                cc = hover_color
            end
        end
        --ret:set_image(img)
        --ret:set_color(cc)
        ret.color = cc
        ret.background_color = cc
    end
    ret.state = ""
    if action then
        ret:buttons(abutton({ }, 1, nil, function()
            ret.state = ""
            update()
            action(c, selector(c))
        end))
    else
        ret:buttons(abutton({ }, 1, nil, function()
            ret.state = ""
            update()
        end))
    end
    ret:connect_signal("mouse::enter", function()
        ret.state = "hover"
        update()
    end)
    ret:connect_signal("mouse::leave", function()
        ret.state = ""
        update()
    end)
    ret:connect_signal("button::press", function(_, _, _, b)
        if b == 1 then
            ret.state = "press"
            update()
        end
    end)
    ret.update = update
    update()

    update_on_signal(c, "focus", ret)
    update_on_signal(c, "unfocus", ret)

    return ret
end


function btn_close(c)
    return btn(c, 
               "close",
               function() return "" end,
               function(cl) cl:kill() end, 
               btn_close_color, 
               btn_close_hover_color)
end

function btn_minimized(c)
    local widget = btn(c, 
                       "minimize",
                       function() return "" end,
                       function(cl) cl.minimized = not cl.minimized end,
                       btn_minimized_color,
                       btn_minimized_hover_color)
    update_on_signal(c, "property::minimized", widget)
    return widget
end

function btn_maximized(c)
    local widget = btn(c, 
                       "maximized",
                       function(cl)
                           return cl.maximized
                       end,
                       function(cl, state)
                           cl.maximized = not state
                       end,
                       btn_maximized_color,
                       btn_maximized_hover_color)
    update_on_signal(c, "property::maximized", widget)
    return widget
end

client.connect_signal("request::titlebars", function(c)
    local buttons = titlebars.buttons

    local title_widget
    if beautiful.titlebar_title_enabled then
        title_widget = awful.titlebar.widget.titlewidget(c)
        title_widget.font = beautiful.titlebar_font
        title_widget:set_align(beautiful.titlebar_title_align)
    else
        title_widget = wibox.widget.textbox("")
    end

    if beautiful.titlebars_imitate_borders then
        --helpers.create_titlebar(c, buttons, "top", beautiful.titlebar_size)
        helpers.create_titlebar(c, buttons, "bottom", dpi(3))
        helpers.create_titlebar(c, buttons, "left", dpi(3))
        helpers.create_titlebar(c, buttons, "right", dpi(3))
    end

    helpers.create_titlebar(c, buttons, "bottom", dpi(3))
    helpers.create_titlebar(c, buttons, "left", dpi(3))
    helpers.create_titlebar(c, buttons, "right", dpi(3))

    local titlebar_item_layout
    local titlebar_layout
    if beautiful.titlebar_position == "left" or beautiful.titlebar_position == "right" then
        titlebar_item_layout = wibox.layout.fixed.vertical
        titlebar_layout = wibox.layout.align.vertical
    else
        titlebar_item_layout = wibox.layout.fixed.horizontal
        titlebar_layout = wibox.layout.align.horizontal
    end

    awful.titlebar(c, {font = beautiful.titlebar_font, position = beautiful.titlebar_position, size = beautiful.titlebar_size}) : setup {
            -- Titlebar items
            { -- Left
                layout  = titlebar_item_layout
            },
            { -- Middle
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { -- Right
                btn_maximized(c),
                btn_minimized(c),
                {
                    btn_close(c),
                    right = dpi(2),
                    widget = wibox.container.margin,
                },
                -- buttons = buttons,
                layout = titlebar_item_layout
            },
            layout = titlebar_layout
            --layout = wibox.layout.align.horizontal
        }
end)

return titlebars
