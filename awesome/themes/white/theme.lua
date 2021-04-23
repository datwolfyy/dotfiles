---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local cairo = require("lgi").cairo
local gears = require("gears")

local gfs = require("gears.filesystem")
local themes_path = "/home/bendeguz/.config/awesome/themes/"

local theme = {}

theme.font          = "sans 8"

theme.bg_normal     = "#9baec9"
theme.bg_focus      = "#6580a8"
theme.bg_urgent     = "#4f5b70"
theme.bg_minimize   = "#9baec9" 
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#1e2024"
theme.fg_focus      = "#1e2024"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#1e2024"

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
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
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
theme.notification_font = "SF Pro Display 11"
theme.notification_bg = "#4f5b70"
theme.notification_fg = "#ffffff"
theme.notification_margin = 0
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."white/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load

theme.wallpaper = themes_path.."white/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."white/layouts/fairh.png"
theme.layout_fairv = themes_path.."white/layouts/fairv.png"
theme.layout_floating  = themes_path.."white/layouts/floating.png"
theme.layout_magnifier = themes_path.."white/layouts/magnifier.png"
theme.layout_max = themes_path.."white/layouts/max.png"
theme.layout_fullscreen = themes_path.."white/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path.."white/layouts/tilebottom.png"
theme.layout_tileleft   = themes_path.."white/layouts/tileleft.png"
theme.layout_tile = themes_path.."white/layouts/tile.png"
theme.layout_tiletop = themes_path.."white/layouts/tiletop.png"
theme.layout_spiral  = themes_path.."white/layouts/spiral.png"
theme.layout_dwindle = themes_path.."white/layouts/dwindle.png"
theme.layout_cornernw = themes_path.."white/layouts/cornernw.png"
theme.layout_cornerne = themes_path.."white/layouts/cornerne.png"
theme.layout_cornersw = themes_path.."white/layouts/cornersw.png"
theme.layout_cornerse = themes_path.."white/layouts/cornerse.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Vimix-dark"

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
