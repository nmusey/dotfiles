-- palette.lua
-- Reads pywal colors from environment variables (exported via ~/.theme.zsh).
-- Falls back to ~/.cache/wal/colors.json, then to built-in defaults.
--
-- Env vars expected: background, foreground, color0..color15
-- (Set by sourcing ~/.cache/wal/colors.sh with `set -a` in the shell)

local M = {}

-- Read colors.json as a fallback when env vars aren't available
local function load_json_colors()
    local path = vim.fn.expand("~/.cache/wal/colors.json")
    local f = io.open(path, "r")
    if not f then return nil end
    local ok, data = pcall(vim.fn.json_decode, f:read("*a"))
    f:close()
    if not ok or not data then return nil end

    local c = {}
    if data.special then
        c.background = data.special.background
        c.foreground  = data.special.foreground
    end
    if data.colors then
        for k, v in pairs(data.colors) do
            c[k] = v
        end
    end
    return c
end

local function resolve()
    local env = vim.env
    local j   = load_json_colors() or {}

    -- Helper: env var → json fallback → hardcoded default
    local function pick(env_key, json_key, default)
        local v = env[env_key]
        if v and v ~= "" then return v end
        return j[json_key] or default
    end

    local bg      = pick("background", "background", "#111318")
    local fg      = pick("foreground", "foreground", "#f8faff")
    local c0      = pick("color0",  "color0",  "#111318")
    local c1      = pick("color1",  "color1",  "#ff9fb9")
    local c2      = pick("color2",  "color2",  "#a5ffb3")
    local c3      = pick("color3",  "color3",  "#ffd9a0")
    local c4      = pick("color4",  "color4",  "#b9cfff")
    local c5      = pick("color5",  "color5",  "#c5d7ff")
    local c6      = pick("color6",  "color6",  "#dae5ff")
    local c7      = pick("color7",  "color7",  "#999da5")
    local c8      = pick("color8",  "color8",  "#5c6170")
    local c9      = pick("color9",  "color9",  "#ff9fb9")
    local c10     = pick("color10", "color10", "#a5ffb3")
    local c11     = pick("color11", "color11", "#ffd9a0")
    local c12     = pick("color12", "color12", "#b9cfff")
    local c13     = pick("color13", "color13", "#c5d7ff")
    local c14     = pick("color14", "color14", "#dae5ff")
    local c15     = pick("color15", "color15", "#f8faff")

    -- Slightly lighter than bg for inactive surfaces
    local bg_alt = c0 ~= bg and c0 or c8

    return {
        bg      = bg,
        bg_alt  = bg_alt,
        fg      = fg,
        muted   = c7,
        dark    = c8,

        -- Semantic accent colours mapped from pywal positions
        pink    = c9,   -- bright red/pink
        green   = c10,  -- bright green
        yellow  = c11,  -- bright yellow
        blue    = c12,  -- bright blue
        purple  = c13,  -- bright purple/magenta
        cyan    = c14,  -- bright cyan

        -- Base variants (dimmer versions)
        pink_dim   = c1,
        green_dim  = c2,
        yellow_dim = c3,
        blue_dim   = c4,
        purple_dim = c5,
        cyan_dim   = c6,

        -- All raw colours in case a plugin needs them
        c0 = c0, c1 = c1, c2 = c2,  c3  = c3,
        c4 = c4, c5 = c5, c6 = c6,  c7  = c7,
        c8 = c8, c9 = c9, c10 = c10, c11 = c11,
        c12 = c12, c13 = c13, c14 = c14, c15 = c15,
    }
end

-- Lazily evaluated and cached per startup; call M.reload() after a wal run
local _cache = nil

function M.get()
    if not _cache then _cache = resolve() end
    return _cache
end

function M.reload()
    _cache = resolve()
    return _cache
end

return M
