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

theme.bg_normal     = "#A6BED6"
theme.bg_focus      = "#90AAC3"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#8AA0B4"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#304860"
theme.fg_focus      = "#000000"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#283847"

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(1)
theme.border_normal = "#000000"
theme.border_focus  = "#92AAC2"
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
theme.titlebar_bg_normal = theme.bg_focus .. "75"
theme.titlebar_fg_normal = theme.fg_normal
theme.titlebar_bg_focus = theme.bg_normal .. "55"
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
theme.menu_submenu_icon = themes_path.."43w/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(130)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."43w/titlebar/close_light.png"
theme.titlebar_close_button_focus  = themes_path.."43w/titlebar/close_light.png"
theme.titlebar_close_button_focus_hover  = themes_path.."43w/titlebar/close_hover_light.png"

theme.titlebar_minimize_button_normal = themes_path.."43w/titlebar/minimize_light.png"
theme.titlebar_minimize_button_focus  = themes_path.."43w/titlebar/minimize_light.png"
theme.titlebar_minimize_button_focus_hover  = themes_path.."43w/titlebar/minimize_hover_light.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."43w/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."43w/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."43w/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."43w/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."43w/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."43w/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."43w/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."43w/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."43w/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."43w/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."43w/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."43w/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."43w/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_focus_inactive  = themes_path.."43w/titlebar/maximize_light.png"
theme.titlebar_maximized_button_focus_inactive_hover  = themes_path.."43w/titlebar/maximize_hover_light.png"
theme.titlebar_maximized_button_focus_active= themes_path.."43w/titlebar/maximize_light.png"
theme.titlebar_maximized_button_focus_active_hover  = themes_path.."43w/titlebar/maximize_hover_light.png"

theme.wallpaper = themes_path.."43w/svalbard2_med.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."43w/layouts/fairh.png"
theme.layout_fairv = themes_path.."43w/layouts/fairv.png"
theme.layout_floating  = themes_path.."43w/layouts/floating.png"
theme.layout_magnifier = themes_path.."43w/layouts/magnifier.png"
theme.layout_max = themes_path.."43w/layouts/max.png"
theme.layout_fullscreen = themes_path.."43w/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path.."43w/layouts/tilebottom.png"
theme.layout_tileleft   = themes_path.."43w/layouts/tileleft.png"
theme.layout_tile = themes_path.."43w/layouts/tile.png"
theme.layout_tiletop = themes_path.."43w/layouts/tiletop.png"
theme.layout_spiral  = themes_path.."43w/layouts/spiral.png"
theme.layout_dwindle = themes_path.."43w/layouts/dwindle.png"
theme.layout_cornernw = themes_path.."43w/layouts/cornernw.png"
theme.layout_cornerne = themes_path.."43w/layouts/cornerne.png"
theme.layout_cornersw = themes_path.."43w/layouts/cornersw.png"
theme.layout_cornerse = themes_path.."43w/layouts/cornerse.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
