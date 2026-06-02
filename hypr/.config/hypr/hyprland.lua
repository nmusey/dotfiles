local bindings = {
    ["space"]     = hl.dsp.exec_cmd("fuzzel"),
    ["t"]         = hl.dsp.exec_cmd("wezterm"),
    ["m"]         = hl.dsp.exec_cmd("spotify --enable-features=UseOzonePlatform --ozoen-platform=wayland"),
    ["n"]         = hl.dsp.exec_cmd("obsidian"),
    ["p"]         = hl.dsp.exec_cmd("hyprshot -m region"),

    ["shift + w"] = hl.dsp.exec_cmd("~/.local/bin/waywall"),

    ["e"]         = hl.dsp.window.fullscreen(),
    ["f"]         = hl.dsp.window.float(),
    ["q"]         = hl.dsp.window.close(),
    ["r"]         = hl.dsp.submap("resize"),
    ["w"]         = hl.dsp.layout("colresize"),

    ["shift + x"] = hl.dsp.exec_cmd("hyprshutdown"),
    ["shift + p"] = hl.dsp.window.pin(),
    ["shift + r"] = hl.dsp.exec_cmd("hyperctl reload"),

    ["h"]         = hl.dsp.focus("left"),
    ["j"]         = hl.dsp.focus("down"),
    ["k"]         = hl.dsp.focus("up"),
    ["l"]         = hl.dsp.focus("right"),
    ["u"]         = hl.dsp.focus("prev"),
    ["o"]         = hl.dsp.focus("next"),

    ["shift + h"] = hl.dsp.window.move("left"),
    ["shift + j"] = hl.dsp.window.move("down"),
    ["shift + k"] = hl.dsp.window.move("up"),
    ["shift + l"] = hl.dsp.window.move("right"),
}

local resize_bindings = {
}

for i = 1,9 do
    bindings[tostring(i)] = hl.dsp.focus(i)
    bindings["shift + " .. tostring(i)] = hl.dsp.window.move(i)
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

hl.config({
    general = {
        gaps_in = 8,
        gaps_out = 16,

        border_size = 2,
        col = {
            active_border = "#33ccffee #00ff99ee",
            inactive_border = "#595959aa",
        },

        resize_on_border = true,
        extend_border_grab_area = 12,
        hover_icon_on_border = true,

        no_focus_fallback = true,
        resize_corner = 0,

        layout = "dwindle",
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

        animations = {
            enabled = true,
            workspace_wraparound = true,
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
        display_splash_rendering = false,
    },
})

hl.monitor({
    output = "DP-2",
    mode = "2560x1440@165",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@60",
    position = "auto-center-up",
    scale = 1,
})
