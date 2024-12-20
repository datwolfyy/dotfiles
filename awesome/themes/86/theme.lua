local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local cairo = require("lgi").cairo
local gears = require("gears")

local gfs = require("gears.filesystem")
local themes_path = "/home/bendeguz/.config/awesome/themes/"

local theme = {}

--theme.font          = "Nunito Regular 9"
theme.font          = "Fira Mono 9"

theme.bg_normal     = "#380A3B"
--theme.bg_normal     = "#24062A"
theme.bg_focus      = "#24062A"
theme.bg_urgent     = "#AA4828"
theme.bg_minimize   = "#59005F"
theme.bg_systray    = theme.bg_normal
theme.systray_icon_spacing = 4

theme.fg_normal     = "#DED3E0"
theme.fg_focus      = "#DFDFDF"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#DED3E0"

theme.useless_gap         = dpi(0)
theme.border_width        = dpi(1)
theme.border_color_normal = "#000000"
theme.border_color_active = "#B174B2"
theme.border_color_marked = "#91231c"

theme.hotkeys_modifiers_fg = "#FBE2FF"

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
theme.notification_font = "Inconsolata 13"
theme.notification_bg = "#2C0541"
theme.notification_fg = "#DED3E0"
--theme.notification_border_color = "#B174B2"
theme.notification_border_color = theme.notification_bg
theme.notification_shape = gears.shape.rounded_rect
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."86/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(130)

theme.tasklist_shape = gears.shape.rect

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load

theme.wallpaper = themes_path.."86/background.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."86/layouts/fairhw.png"
theme.layout_fairv = themes_path.."86/layouts/fairvw.png"
theme.layout_floating  = themes_path.."86/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."86/layouts/magnifierw.png"
theme.layout_max = themes_path.."86/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."86/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."86/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."86/layouts/tileleftw.png"
theme.layout_tile = themes_path.."86/layouts/tilew.png"
theme.layout_tiletop = themes_path.."86/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."86/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."86/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."86/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."86/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."86/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."86/layouts/cornersew.png"

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
