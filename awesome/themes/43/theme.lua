---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "themes/"

local theme = {}

theme.font          = "B612 Mono 8"

theme.bg_normal     = "#131317"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#292929"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#bbbbbb"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#888888"

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(1)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

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
theme.titlebar_bg_normal = theme.bg_focus .. "89"
theme.titlebar_fg_normal = theme.fg_normal
theme.titlebar_bg_focus = theme.bg_normal .. "B5"
theme.titlebar_fg_focus = theme.fg_focus

theme.tasklist_disable_icon = true
theme.tasklist_minimized = "_"

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
theme.menu_submenu_icon = themes_path.."43/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(130)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."43/titlebar/close_dark.png"
theme.titlebar_close_button_focus  = themes_path.."43/titlebar/close_dark.png"
theme.titlebar_close_button_focus_hover  = themes_path.."43/titlebar/close_hover_color.png"

theme.titlebar_minimize_button_normal = themes_path.."43/titlebar/minimize_dark.png"
theme.titlebar_minimize_button_focus  = themes_path.."43/titlebar/minimize_dark.png"
theme.titlebar_minimize_button_focus_hover  = themes_path.."43/titlebar/minimize_hover_color.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."43/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."43/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."43/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."43/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."43/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."43/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."43/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."43/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."43/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."43/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."43/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."43/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."43/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_focus_inactive  = themes_path.."43/titlebar/maximize_dark.png"
theme.titlebar_maximized_button_focus_inactive_hover  = themes_path.."43/titlebar/maximize_hover_color.png"
theme.titlebar_maximized_button_focus_active= themes_path.."43/titlebar/maximize_dark.png"
theme.titlebar_maximized_button_focus_active_hover  = themes_path.."43/titlebar/maximize_hover_color.png"

theme.wallpaper = themes_path.."43/ur1.jpg"
--theme.wallpaper = themes_path.."43/auchynnikau.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."43/layouts/fairhw.png"
theme.layout_fairv = themes_path.."43/layouts/fairvw.png"
theme.layout_floating  = themes_path.."43/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."43/layouts/magnifierw.png"
theme.layout_max = themes_path.."43/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."43/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."43/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."43/layouts/tileleftw.png"
theme.layout_tile = themes_path.."43/layouts/tilew.png"
theme.layout_tiletop = themes_path.."43/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."43/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."43/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."43/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."43/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."43/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."43/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height+5, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
