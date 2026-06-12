local bindings = {
    ["space"]     = hl.dsp.exec_cmd("fuzzel"),
    ["b"]         = hl.dsp.exec_cmd("zen-browser"),
    ["m"]         = hl.dsp.exec_cmd("spotify --enable-features=UseOzonePlatform --ozone-platform=wayland"),
    ["n"]         = hl.dsp.exec_cmd("obsidian"),
    ["p"]         = hl.dsp.exec_cmd("hyprshot -m region"),
    ["t"]         = hl.dsp.exec_cmd("kitty"),

    ["SHIFT + w"] = hl.dsp.exec_cmd("~/.local/bin/waywall"),

    ["e"]         = hl.dsp.window.fullscreen(),
    ["f"]         = hl.dsp.window.float(),
    ["q"]         = hl.dsp.window.close(),
    ["r"]         = hl.dsp.submap("resize"),
    ["w"]         = hl.dsp.layout("colresize"),

    ["SHIFT + x"] = hl.dsp.exec_cmd("hyprshutdown"),
    ["SHIFT + p"] = hl.dsp.window.pin(),
    ["SHIFT + r"] = hl.dsp.exec_cmd("hyperctl reload"),

    ["h"]         = hl.dsp.focus({ direction = "left" }),
    ["j"]         = hl.dsp.focus({ direction = "down" }),
    ["k"]         = hl.dsp.focus({ direction = "up" }),
    ["l"]         = hl.dsp.focus({ direction = "right" }),

    ["SHIFT + h"] = hl.dsp.window.move({ direction = "left" }),
    ["SHIFT + j"] = hl.dsp.window.move({ direction = "down" }),
    ["SHIFT + k"] = hl.dsp.window.move({ direction = "up" }),
    ["SHIFT + l"] = hl.dsp.window.move({ direction = "right" }),
}

for i = 1,9 do
    bindings[tostring(i)] = hl.dsp.focus({ workspace=tostring(i) })
    bindings["SHIFT + " .. tostring(i)] = hl.dsp.window.move({ workspace=tostring(i) })
end

local mouse_binds = {
    ["mouse:272"] = hl.dsp.window.drag(),
    ["mouse:273"] = hl.dsp.window.resize(),
}

local mod = "SUPER"
for key, action in pairs(bindings) do
    hl.bind(mod .. " + " .. key, action)
end

for button, action in pairs(mouse_binds) do
    hl.bind(mod .. " + " .. button, action, { mouse = true })
end

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true } )

hl.config({
    general = {
        gaps_in = 8,
        gaps_out = 16,

        border_size = 2,
        col = {
            active_border = "#33ccffee",
            inactive_border = "#595959aa",
        },

        resize_on_border = true,
        extend_border_grab_area = 12,
        hover_icon_on_border = true,

        no_focus_fallback = true,
        resize_corner = 0,

        layout = "dwindle",
    },

    cursor = {
        default_monitor = "DP-2",
    },

    decoration = {
        rounding = 8,

        border_part_of_window = true,

        active_opacity = 1.0,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1.0,

        dim_modal = true,
        dim_inactive = true,
        dim_special = 0.2,
        dim_strength = 0.5,

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.17,
            xray = true,
        },

        shadow = {
            enabled = true,
        },

        glow = {
            enabled = true,
            range = 4,
        },
    },

    xwayland = {
        enabled = true,
    },

    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,

    },

    misc = {
        disable_hyprland_logo = true,
    },
})

hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true })
hl.monitor({
    output = "DP-2",
    mode = "2560x1440@165",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@60",
    position = "auto-up",
    scale = 1,
})

hl.on("hyprland.start", function()
    hl.exec_cmd("wal -c && wal -i ~/Pictures/Wallpapers/wallpaper.jpg")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("wayclip")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("waybar &")
end)
