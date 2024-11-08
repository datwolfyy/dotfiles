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
-- Launch menu and desktop icons
local freedesktop = require("freedesktop")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/current/theme.lua")

terminal = "zutty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Autostart
awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "autorun.sh")

-- Modkey (Alt)
modkey = "Mod1"

-- Rightclick menu
settings_menu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart awesome", awesome.restart },
    { "quit awesome", function() awesome.quit() end }
}

rightclick_menu = freedesktop.menu.build({
	after = {
		{ "settings", settings_menu },
		{ "open terminal", terminal }
	},
	sub_menu = "programs"
})

--[[rightclick_menu = awful.menu({ items = { { "launch...", programs_menu  },
					 { "settings", settings_menu },
                                         { "open terminal", terminal }
                                        }
                            })--]]

menubar.utils.terminal = terminal
menubar.show_categories = false
menubar.match_empty = true
menubar.geometry = {
    height = 30
}

tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.floating,
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.tile.top,
        awful.layout.suit.fair,
        awful.layout.suit.fair.horizontal,
        awful.layout.suit.spiral,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.max,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.magnifier,
        awful.layout.suit.corner.nw,
    })
end)

-- Keyboard layout indicator and switcher
bar_keyboardlayout = awful.widget.keyboardlayout()

-- Clock
bar_textclock = wibox.widget.textclock("%Y.%m.%d. %H:%M:%S", 1)

-- Separator
local bar_separator = wibox.widget {
	widget = wibox.widget.separator,
	orientation = "vertical",
	forced_width = 10,
	color = beautiful.get().fg_normal,
}
local tasklist_separator = wibox.widget {
    widget = wibox.widget.separator,
    orientation = "horizontal",
    forced_width = 40,
    visible = true,
    color = "#00000000"
}

-- Disk usage
local bar_disk_usage = awful.widget.watch(
    { awful.util.shell, "-c", "df -BM | awk '/^\\// {print $3\"/\"$2;exit}'" },
    180,
    function (widget, stdout)
        widget:set_text("disk: "..stdout)
    end
)
-- CPU temperature
local bar_cpu_temp = awful.widget.watch(
    { awful.util.shell, "-c", "sensors | awk '/Package/ {print $4}'" },
    3,
    function (widget, stdout)
        widget:set_text("temp: "..stdout)
    end
)
-- RAM usage
local bar_ram_usage = awful.widget.watch(
    { awful.util.shell, "-c", "free -m | awk '/Mem:/ {print $3\"M\"\"/\"$2\"M\"}'" },
    3,
    function (widget, stdout)
        widget:set_text("mem: "..stdout)
    end
)

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, false)
    end    
end)

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({"1", "2", "3", "4", "5"}, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.promptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.layoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    -- Create a taglist widget
    s.taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    s.tasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        },
        widget_template = {
                {
                    {
                        {
                            {
                                {
                                    id     = "icon_role",
                                    widget = wibox.widget.imagebox,
                                },
                                margins = 1,
                                right = 6,
                                widget  = wibox.container.margin,
                            },
                            {
                                id     = "text_role",
                                widget = wibox.widget.textbox,
                            },
                            layout = wibox.layout.fixed.horizontal,
                        },
                        left  = 4,
                        right = 4,
                        widget = wibox.container.margin
                    },
                    id     = "background_role",
                    widget = wibox.container.background,
            },
            --top = 2,
            --bottom = 2,
	    left = 4,
	    right = 4,
            widget = wibox.container.margin
        }
    }

    s.wibox = awful.wibar({ position = "bottom", screen = s, height = 22})

    s.wibox.widget = {
        layout = wibox.layout.align.horizontal,
        { -- Left
            layout = wibox.layout.fixed.horizontal,
            s.taglist,
            s.promptbox,
        },
        s.tasklist, -- Middle
        { -- Right
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            bar_separator,
            bar_cpu_temp,
            bar_separator,
            bar_ram_usage,
            bar_separator,
            --bar_disk_usage,
            --bar_separator,
            bar_textclock,
	    bar_separator,
            bar_keyboardlayout,
            bar_separator,
            s.layoutbox
        }
    }
end)

-- Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () rightclick_menu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})

-- {{{ Keybindings
-- general
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "p", hotkeys_popup.show_help,
        { description="show help", group="awesome" }),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", function () awesome.quit() end,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey }, "s", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    awful.key({ modkey }, "r", 
            function ()
                awful.prompt.run {
                    prompt  = "Search for unicode characters: ",
                    textbox = awful.screen.focused().promptbox.widget,
                    -- unicode char search here...
                }
            end, {description = "run prompt", group = "launcher"}),
    awful.key({  }, "Print", function () awful.spawn.with_shell("maim -s screenshots/$(date +%s%N).png") end,
              {description = "take a screenshot of selected area", group = "screen"}),
    awful.key({ modkey }, "Print", function () awful.spawn.with_shell("maim screenshots/$(date +%s%N).png") end,
    		{description = "take a screenshot of the whole screen", group = "screen"}),
})
-- tags
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
})

-- focus
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({  }, "XF86AudioPlay", function () awful.spawn.with_shell("playerctl play-pause") end,
              {description = "play/pause music", group = "client"}),
    awful.key({  }, "XF86AudioStop", function () awful.spawn.with_shell("playerctl stop") end,
              {description = "stop music", group = "client"}),
    awful.key({  }, "XF86AudioPrev", function () awful.spawn.with_shell("playerctl previous") end,
              {description = "play last song", group = "client"}),
    awful.key({  }, "XF86AudioNext", function () awful.spawn.with_shell("playerctl next") end,
              {description = "play next song", group = "client"}),
    awful.key({  }, "XF86AudioMute", function() awful.spawn.with_shell("playerctl volume 0") end,
              {description = "mute music", group = "client"}),
    awful.key({  }, "XF86AudioLowerVolume", function () awful.spawn.with_shell("playerctl volume 0.05-") end,
              {description = "lower music volume", group = "client"}),
    awful.key({  }, "XF86AudioRaiseVolume", function () awful.spawn.with_shell("playerctl volume 0.05+") end,
              {description = "raise music volume", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {description = "restore minimized", group = "client"}),
})
-- layout
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
})
awful.keyboard.append_global_keybindings({
	    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),
        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, "Control" }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "client"}),
        awful.key({ modkey, "Shift"   }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "client"}),
    })
end)

-- }}}

-- Rules

ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv", "imv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true      }
    }

    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { 
            class = {
		"DawnOfWar2Retribution",
		"DawnOfWar2"
            }
        },
        properties = { titlebars_enabled = false }
    }


    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- ruled.client.append_rule {
    --     rule       = { class = "Firefox"     },
    --     properties = { screen = 1, tag = "2" }
    -- }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- }}}
client.connect_signal("manage", function (c)
	c.size_hints_honor = false
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)
-- Titlebars
client.connect_signal("request::titlebars", function(c)
    -- titlebar buttons
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move" }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize" }
        end),
    }

    awful.titlebar(c, {
        size = 20,
        position = "top"
    }).widget = {
        { -- Left
            { -- Title
                align = "center",
                widget = wibox.container.margin(awful.titlebar.widget.titlewidget(c), 6),
            },
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal,
        },
        { -- Middle
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal,
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal,
            awful.titlebar.widget.minimizebutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton    (c),
        },
        layout = wibox.layout.align.horizontal,
    }
end)

-- {{{ Notifications
ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
