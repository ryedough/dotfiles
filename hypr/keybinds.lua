local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(Terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(FileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(Menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("firefox"))

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
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.device({
    name="msft0001:00-04f3:317c-touchpad",
    natural_scroll=true,
    sensitivity = 0.3,
    relative_input = true,
})

-- pass binds to apps

hl.bind(mainMod .. " + n", hl.dsp.submap("vim-navigation"))
hl.define_submap("vim-navigation", function ()
    hl.bind(mainMod .. " + k", hl.dsp.send_shortcut({mods="", key="up", window="activewindow"}), {repeating = true})
    hl.bind(mainMod .. " + l", hl.dsp.send_shortcut({mods="", key="right", window="activewindow"}), {repeating = true})
    hl.bind(mainMod .. " + j", hl.dsp.send_shortcut({mods="", key="down", window="activewindow"}), {repeating = true})
    hl.bind(mainMod .. " + h", hl.dsp.send_shortcut({mods="", key="left", window="activewindow"}), {repeating = true})
    hl.bind("escape", hl.dsp.submap(("reset")))
end)

-- Resize and move window

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.submap("resize-window"))
hl.bind(mainMod .. " + W", hl.dsp.submap("move-window"))

local function bind_multiple(arr, func, opts)
    for _, key in pairs(arr) do
       hl.bind(key, func, opts)
    end
end

hl.define_submap("move-window", function ()
    bind_multiple({"up", "k"}, hl.dsp.window.swap({direction = "u"}))
    bind_multiple({"right", "l"}, hl.dsp.window.swap({direction = "r"}))
    bind_multiple({"down", "j"}, hl.dsp.window.swap({direction = "d"}))
    bind_multiple({"left", "h"}, hl.dsp.window.swap({direction = "l"}))

    hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.define_submap("resize-window", function ()
    bind_multiple({"up", "k"}, hl.dsp.window.resize({
        x = 0,
        y =-10,
        relative=true,
    }), {repeating = true})
    bind_multiple({"right", "l"}, hl.dsp.window.resize({
        x = 10,
        y = 0,
        relative=true,
    }), {repeating = true})
    bind_multiple({"down", "j"}, hl.dsp.window.resize({
        x = 0,
        y = 10,
        relative=true,
    }), {repeating = true})
    bind_multiple({"left", "h"}, hl.dsp.window.resize({
        x = -10,
        y = 0,
        relative=true,
    }), {repeating = true})

    hl.bind("catchall", hl.dsp.submap("reset"))
end)

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
