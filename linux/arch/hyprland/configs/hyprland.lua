------------------
---- MONITORS ----
------------------

hl.monitor({ output="HDMI-A-1", mode="1920x1080@144", position="0x0", scale="1" }) -- Primary monitor
hl.monitor({ output = "eDP-1", disabled = true }) -- Laptop monitor

---------------------
---- MY PROGRAMS ----
---------------------

-- Essentials
local terminal = "alacritty"
local fileManager = "thunar"
local ide = "code"
local notes = "obsidian"
local vb = "virtualbox"

-- Web
local browser = "firefox"
local tg = "Telegram"
local ds = "discord"

-- Media
local video = "obs"
local videoEditor = "cd ~/Desktop && ./kdenlive.AppImage"

-- Games
local steam = "steam"
local minecraft = "minecraft-launcher"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
    hl.exec_cmd("ice shell &") -- IceShell

    hl.exec_cmd("wl-paste --type text --watch cliphist store &") -- Clipboard
    hl.exec_cmd("wl-paste --type image --watch cliphist store &") -- Clipboard
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(eb7507ee)", "rgba(f77e0cee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,

        allow_tearing = false, -- VSYNC Disabling (false = VSYNC is work)

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

-- Main
local mainMod = "SUPER"
local mainShift = "SUPER + SHIFT"
local mainCtrl = "SUPER + CTRL"
local mainAlt = "SUPER + ALT"
local mainMega = "SUPER + SHIFT + CTRL + ALT"

-- Apps
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal)) -- Terminal
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager)) -- File Manager
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(ide)) -- Code Editor
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(notes)) -- Notes
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd(vb)) -- Virtual Box

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser)) -- Browser
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(ds)) -- Discord
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(tg)) -- Telegram

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(video)) -- Video
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(videoEditor)) -- Video Editor

-- Games
hl.bind(mainAlt .. " + S", hl.dsp.exec_cmd(steam)) -- Steam
hl.bind(mainAlt .. " + M", hl.dsp.exec_cmd(minecraft)) -- Minecraft

-- Windows
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- Close
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" })) -- Split mode toggle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- Split position toggle
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("pkill wofi || hyprctl activewindow -j | jq -r '\"CLASS: \" + .class, \"TITLE: \" + .title' | wofi --conf=$HOME/.config/wofi/config-info --style=$HOME/.config/wofi/style-info.css --show dmenu")) -- Get name and class

-- Screenshot
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots")) -- Screenshot

-- Clipboard
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("pkill wofi || cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainShift .. " + G", hl.dsp.exec_cmd("cliphist wipe & notify-send -e -u normal -t 4000 -i $HOME/Pictures/Icons/Clipboard.png 'Clipboard' 'Successfully cleared!'"))

-- Menu
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill wofi || wofi --show drun")) -- App menu
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("pkill wofi || wofi --show run")) -- Command menu
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd('pkill wofi || bash $HOME/.local/bin/menu.sh')) -- Command menu

-- Warp
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("if warp-cli status | grep -qi 'disconnected'; then warp-cli connect & notify-send -e -u normal -t 4000 -i $HOME/Pictures/Icons/Warp.png 'Warp' 'Connected'; else warp-cli disconnect & notify-send -e -u normal -t 4000 -i $HOME/Pictures/Icons/Warp.png 'Warp' 'Disconnected'; fi"))

-- Volume
hl.bind(mainAlt .. " + Z", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind(mainAlt .. " + X", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })

-- Music
hl.bind(mainAlt .. " + Q",  hl.dsp.exec_cmd("playerctl previous"),{ locked = true })
hl.bind(mainAlt .. " + W", hl.dsp.exec_cmd("playerctl play-pause"),{ locked = true })
hl.bind(mainAlt .. " + E",  hl.dsp.exec_cmd("playerctl next"),{ locked = true })

-- System
hl.bind(mainShift .. " + Q", hl.dsp.exec_cmd("poweroff")) -- Power off
hl.bind(mainShift .. " + W", hl.dsp.exec_cmd("reboot")) -- Reboot
hl.bind(mainShift .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")) -- Logout

-- Keyblock
hl.define_submap("passthrough", function()
    hl.bind(mainMod .. " + Escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + Escape", hl.dsp.submap("passthrough"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))

    hl.bind(mainAlt .. " + " .. key,             hl.dsp.focus({ workspace = i + 10}))
    hl.bind(mainAlt .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i + 10}))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({ -- Size
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({ -- fix xwayland drags
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({ -- hyprland-run
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
