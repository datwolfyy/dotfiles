local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local cairo = require("lgi").cairo
local gears = require("gears")

local gfs = require("gears.filesystem")
local themes_path = "/home/bendeguz/.config/awesome/themes/"
local theme_path = themes_path .. "unix/"

local theme = {}

theme.font          = "Liberation Sans Bold 9"

theme.useless_gap         = dpi(0)
theme.border_width        = dpi(2)
theme.border_color_normal = "#000000"
theme.border_color_active = "#900000"
theme.border_color_marked = "#91231c"

theme.bg_normal     = "#232323"
theme.bg_focus      = "#000000"
theme.bg_urgent     = theme.border_color_active
theme.bg_minimize   = "#191919"
theme.bg_systray    = theme.bg_normal
theme.systray_icon_spacing = 4

theme.fg_normal     = "#BBBBBB"
theme.fg_focus      = "#DFDFDF"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#DFDFDF"


theme.hotkeys_modifiers_fg = "#000000"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
theme.titlebar_bg_normal = "#C0C0C0"
theme.titlebar_fg_normal = "#7A1616"
theme.titlebar_bg_focus = "#7A1616"
theme.titlebar_fg_focus = theme.fg_focus

theme.taglist_bg_empty = theme.bg_normal
theme.tasklist_disable_icon = true
theme.tasklist_minimized = "_"
-- Generate taglist squares:
local taglist_square_size = dpi(3)
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
theme.notification_font = "Nunito Regular 11"
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_border_color = theme.border_color_active
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path.."submenu1.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(150)

theme.tasklist_shape = gears.shape.rect
theme.tasklist_minimized = "_"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

theme.wallpaper = theme_path.."background.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = theme_path.."layouts/fairhw.png"
theme.layout_fairv = theme_path.."layouts/fairvw.png"
theme.layout_floating  = theme_path.."layouts/floatingw.png"
theme.layout_magnifier = theme_path.."layouts/magnifierw.png"
theme.layout_max = theme_path.."layouts/maxw.png"
theme.layout_fullscreen = theme_path.."layouts/fullscreenw.png"
theme.layout_tilebottom = theme_path.."layouts/tilebottomw.png"
theme.layout_tileleft   = theme_path.."layouts/tileleftw.png"
theme.layout_tile = theme_path.."layouts/tilew.png"
theme.layout_tiletop = theme_path.."layouts/tiletopw.png"
theme.layout_spiral  = theme_path.."layouts/spiralw.png"
theme.layout_dwindle = theme_path.."layouts/dwindlew.png"
theme.layout_cornernw = theme_path.."layouts/cornernww.png"
theme.layout_cornerne = theme_path.."layouts/cornernew.png"
theme.layout_cornersw = theme_path.."layouts/cornersww.png"
theme.layout_cornerse = theme_path.."layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

mode = "dark"

theme.titlebar_close_button_focus       =  theme_path.."titlebar/close_" .. mode .. ".png"
theme.titlebar_close_button_focus_hover =  theme_path.."titlebar/close_hover_" .. mode .. ".png"

theme.titlebar_maximized_button_focus_active       =  theme_path.."titlebar/maximize_" .. mode .. ".png"
theme.titlebar_maximized_button_focus_active_hover =  theme_path.."titlebar/maximize_hover_" .. mode .. ".png"

theme.titlebar_maximized_button_focus_inactive       =  theme_path.."titlebar/maximize_" .. mode .. ".png"
theme.titlebar_maximized_button_focus_inactive_hover =  theme_path.."titlebar/maximize_hover_" .. mode .. ".png"

theme.titlebar_minimize_button_focus       =  theme_path.."titlebar/minimize_" .. mode .. ".png"
theme.titlebar_minimize_button_focus_hover =  theme_path.."titlebar/minimize_hover_" .. mode .. ".png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
