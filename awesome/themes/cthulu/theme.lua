local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local cairo = require("lgi").cairo
local gears = require("gears")

local gfs = require("gears.filesystem")
local themes_path = "/home/bendeguz/.config/awesome/themes/"

local theme = {}

theme.font          = "Nunito Regular 9"
-- #AA4828
theme.bg_normal     = "#3E8794"
theme.bg_focus      = "#3F707A"
theme.bg_urgent     = "#3E8794"
theme.bg_minimize   = "#378594"
theme.bg_systray    = theme.bg_normal
theme.systray_icon_spacing = 2

theme.fg_normal     = "#291500"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#291500"

theme.useless_gap         = dpi(0)
theme.border_width        = dpi(1)
theme.border_color_normal = "#000000"
theme.border_color_active = "#378594"
theme.border_color_marked = "#91231c"



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
theme.taglist_bg_empty = theme.bg_normal

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
theme.notification_bg = "#3E8794"
theme.notification_fg = "#ffffff"
theme.notification_border_color = "#378594"
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."cthulu/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

theme.titlebar_close_button_normal = themes_path.."cthulu/titlebar/close_dark.png"
theme.titlebar_close_button_focus  = themes_path.."cthulu/titlebar/close_dark.png"

theme.titlebar_minimize_button_normal = themes_path.."cthulu/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."cthulu/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."cthulu/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."cthulu/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."cthulu/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."cthulu/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."cthulu/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."cthulu/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."cthulu/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."cthulu/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."cthulu/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."cthulu/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."cthulu/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."cthulu/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."cthulu/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."cthulu/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."cthulu/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."cthulu/titlebar/maximized_focus_active.png"

-- Define the image to load

theme.wallpaper = themes_path.."cthulu/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."cthulu/layouts/fairh.png"
theme.layout_fairv = themes_path.."cthulu/layouts/fairv.png"
theme.layout_floating  = themes_path.."cthulu/layouts/floating.png"
theme.layout_magnifier = themes_path.."cthulu/layouts/magnifier.png"
theme.layout_max = themes_path.."cthulu/layouts/max.png"
theme.layout_fullscreen = themes_path.."cthulu/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path.."cthulu/layouts/tilebottom.png"
theme.layout_tileleft   = themes_path.."cthulu/layouts/tileleft.png"
theme.layout_tile = themes_path.."cthulu/layouts/tile.png"
theme.layout_tiletop = themes_path.."cthulu/layouts/tiletop.png"
theme.layout_spiral  = themes_path.."cthulu/layouts/spiral.png"
theme.layout_dwindle = themes_path.."cthulu/layouts/dwindle.png"
theme.layout_cornernw = themes_path.."cthulu/layouts/cornernw.png"
theme.layout_cornerne = themes_path.."cthulu/layouts/cornerne.png"
theme.layout_cornersw = themes_path.."cthulu/layouts/cornersw.png"
theme.layout_cornerse = themes_path.."cthulu/layouts/cornerse.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Luna-Dark"

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
