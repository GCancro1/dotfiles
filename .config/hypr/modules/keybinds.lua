-- Keybindings
local vars = require("variables")
local wsaction = os.getenv("HOME") .. "/.config/hypr-lua/scripts/wsaction.fish"

-- ── Submap setup ────────────────────────────────────────────────
-- The old config used `exec = hyprctl dispatch submap global` + `submap = global`
-- to put all binds in a "global" submap. We replicate this with hl.define_submap.
-- hl.bind("SUPER + SUPER_L", hl.dsp.submap("global"))

-- hl.define_submap("global", function()

-- ── Shell keybinds ──────────────────────────────────────────
-- Launcher
hl.bind("SUPER + Space", hl.dsp.global("caelestia:launcher"))
hl.bind("SUPER + mouse:272", hl.dsp.global("caelestia:launcherInterrupt"), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.global("caelestia:launcherInterrupt"), { mouse = true })
hl.bind("SUPER + mouse:274", hl.dsp.global("caelestia:launcherInterrupt"), { mouse = true })
hl.bind("SUPER + mouse:275", hl.dsp.global("caelestia:launcherInterrupt"), { mouse = true })
hl.bind("SUPER + mouse:276", hl.dsp.global("caelestia:launcherInterrupt"), { mouse = true })
hl.bind("SUPER + mouse:277", hl.dsp.global("caelestia:launcherInterrupt"), { mouse = true })
hl.bind("SUPER + mouse_up", hl.dsp.global("caelestia:launcherInterrupt"))
hl.bind("SUPER + mouse_down", hl.dsp.global("caelestia:launcherInterrupt"))

-- Misc shell
hl.bind(vars.kbSession .. " + Delete", hl.dsp.global("caelestia:session"))
hl.bind("SUPER + Backspace", hl.dsp.global("caelestia:session"))
hl.bind(vars.kbShowSidebar .. " + N", hl.dsp.global("caelestia:sidebar"))
hl.bind(vars.kbClearNotifs .. " + C", hl.dsp.global("caelestia:clearNotifs"), { locked = true })
hl.bind(vars.kbShowPanels .. " + K", hl.dsp.global("caelestia:showall"))
hl.bind(vars.kbLock .. " + L", hl.dsp.global("caelestia:lock"))

-- Restore lock
hl.bind(vars.kbRestoreLock .. " + L", hl.dsp.exec_cmd("caelestia shell -d"), { locked = true })
hl.bind(vars.kbRestoreLock .. " + L", hl.dsp.global("caelestia:lock"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true })

-- Media
hl.bind("CTRL + SUPER + Space", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("CTRL + SUPER + Equal", hl.dsp.global("caelestia:mediaNext"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.global("caelestia:mediaNext"), { locked = true })
hl.bind("CTRL + SUPER + Minus", hl.dsp.global("caelestia:mediaPrev"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.global("caelestia:mediaPrev"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.global("caelestia:mediaStop"), { locked = true })

-- Kill/restart
hl.bind("CTRL + SUPER + SHIFT + R", hl.dsp.exec_cmd("qs -c caelestia kill"), { release = true })
hl.bind("CTRL + SUPER + ALT + R", hl.dsp.exec_cmd("qs -c caelestia kill; sleep .1; caelestia shell -d"), { release = true })
hl.bind("CTRL + SHIFT + ALT + R", hl.dsp.exec_cmd("qs -c caelestia kill; sleep .1; caelestia shell -d"), { release = true })

-- ── Go to workspace # ──────────────────────────────────────
for i = 1, 10 do
local key = i % 10
hl.bind(vars.kbGoToWs .. " + " .. key, hl.dsp.focus({ workspace = i}))
-- hl.bind(vars.kbGoToWsGroup .. " + " .. key, hl.dsp.exec_cmd(wsaction .. " -g workspace " .. i))
end

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
-- Go to workspace -1/+1
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(vars.kbPrevWs .. " + left", hl.dsp.focus({ workspace = "e-1" }), { repeating = true })
hl.bind(vars.kbNextWs .. " + right", hl.dsp.focus({ workspace = "e+1" }), { repeating = true })
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "e-1" }), { repeating = true })
hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "e+1" }), { repeating = true })

-- Go to workspace group -1/+1
hl.bind("CTRL + SUPER + mouse_down", hl.dsp.focus({ workspace = "e-10" }))
hl.bind("CTRL + SUPER + mouse_up", hl.dsp.focus({ workspace = "e+10" }))

-- Toggle special workspace
hl.bind(vars.kbToggleSpecialWs .. " + S", hl.dsp.exec_cmd("caelestia toggle specialws"))

-- ── Move window to workspace # ─────────────────────────────
for i = 1, 10 do
local key = i % 10
hl.bind(vars.kbMoveWinToWs .. " + " .. key, hl.dsp.window.move({workspace = i}))
-- hl.bind(vars.kbMoveWinToWsGroup .. " + " .. key, hl.dsp.exec_cmd(wsaction .. " -g movetoworkspace " .. i))
end

-- Move window to workspace -1/+1
hl.bind("SUPER + ALT + Page_Up", hl.dsp.window.move({ workspace = "e-1" }), { repeating = true })
hl.bind("SUPER + ALT + Page_Down", hl.dsp.window.move({ workspace = "e+1" }), { repeating = true })
hl.bind("SUPER + ALT + mouse_down", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + ALT + mouse_up", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("CTRL + SUPER + SHIFT + right", hl.dsp.window.move({ workspace = "e+1" }), { repeating = true })
hl.bind("CTRL + SUPER + SHIFT + left", hl.dsp.window.move({ workspace = "e-1" }), { repeating = true })

-- Move window to/from special workspace
hl.bind("CTRL + SUPER + SHIFT + up", hl.dsp.window.move({ workspace = "special:special" }))
hl.bind("CTRL + SUPER + SHIFT + down", hl.dsp.window.move({ workspace = "e+0" }))
hl.bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special:special" }))

-- ── Window groups ──────────────────────────────────────────
hl.bind(vars.kbWindowGroupCycleNext .. " + Tab", hl.dsp.group.next(), { repeating = true })
hl.bind(vars.kbWindowGroupCyclePrev .. " + Tab", hl.dsp.group.prev(), { repeating = true })
hl.bind("CTRL + ALT + Tab", hl.dsp.group.next(), { repeating = true })
hl.bind("CTRL + SHIFT + ALT + Tab", hl.dsp.group.prev(), { repeating = true })
hl.bind(vars.kbToggleGroup .. " + Comma", hl.dsp.group.toggle())
hl.bind(vars.kbUngroup .. " + U", hl.dsp.window.move({ out_of_group = true }))
hl.bind("SUPER + SHIFT + Comma", hl.dsp.group.lock({ action = "toggle" }))

-- ── Window actions ─────────────────────────────────────────
hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))

hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

hl.bind("SUPER + Minus", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + Equal", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + Minus", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + Equal", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
hl.bind("SUPER + ALT + left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + ALT + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + ALT + up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
hl.bind("SUPER + ALT + down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

-- Mouse move/resize
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(vars.kbMoveWindow .. " + Z", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(vars.kbResizeWindow .. " + X", hl.dsp.window.resize(), { mouse = true })

-- Center / PiP / Pin / Fullscreen / Float / Close / Minimize
-- Center on monitor 1
hl.bind("CTRL + SUPER + Backslash", hl.dsp.window.center(), { repeating = true })

-- Resize to 55% x 70% and center (uses hyprctl since Lua API has no exact resize)
hl.bind("CTRL + SUPER + ALT + Backslash", function()
hl.dispatch(hl.dsp.exec_cmd("hyprctl dispatch resizeactive exact 55% 70%"))
hl.dispatch(hl.dsp.window.center())
end, { repeating = true })
hl.bind(vars.kbWindowPip .. " + Backslash", hl.dsp.exec_cmd("caelestia resizer pip"))
hl.bind(vars.kbPinWindow .. " + P", hl.dsp.window.pin())
hl.bind(vars.kbWindowFullscreen .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(vars.kbWindowBorderedFullscreen .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(vars.kbToggleWindowFloating .. " + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(vars.kbCloseWindow .. " + Q", hl.dsp.window.close())
hl.bind(vars.kbMinimize .. " + H", hl.dsp.window.move({ workspace = "special:minimized" }))

-- ── Special workspace toggles ──────────────────────────────
hl.bind(vars.kbSystemMonitor .. " + Escape", hl.dsp.exec_cmd("caelestia toggle sysmon"))
hl.bind(vars.kbMusic .. " + M", hl.dsp.exec_cmd("caelestia toggle music"))
hl.bind(vars.kbCommunication .. " + D", hl.dsp.exec_cmd("caelestia toggle communication"))
hl.bind(vars.kbTodo .. " + R", hl.dsp.exec_cmd("caelestia toggle todo"))

-- ── Apps ───────────────────────────────────────────────────
hl.bind(vars.kbTerminal .. " + T", hl.dsp.exec_cmd("app2unit -- " .. vars.terminal))
hl.bind(vars.kbBrowser .. " + W", hl.dsp.exec_cmd("app2unit -- " .. vars.browser))
-- hl.bind(vars.kbEditor .. " + C", hl.dsp.exec_cmd("app2unit -- " .. vars.editor))
hl.bind(vars.kbFileExplorer .. " + E", hl.dsp.exec_cmd("app2unit -- " .. vars.fileExplorer))

-- ── Utilities ──────────────────────────────────────────────
hl.bind("Print", hl.dsp.exec_cmd("caelestia screenshot"), { locked = true })
hl.bind("SUPER + SHIFT + S", hl.dsp.global("caelestia:screenshotFreeze"))
hl.bind("SUPER + SHIFT + ALT + S", hl.dsp.global("caelestia:screenshot"))
hl.bind("SUPER + ALT + R", hl.dsp.exec_cmd("caelestia record -s"))
hl.bind("CTRL + ALT + R", hl.dsp.exec_cmd("caelestia record"))
hl.bind("SUPER + SHIFT + ALT + R", hl.dsp.exec_cmd("caelestia record -r"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Volume
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ " .. vars.volumeStep .. "%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. vars.volumeStep .. "%-"), { locked = true, repeating = true })

-- Sleep
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("systemctl suspend-then-hibernate"), { locked = true })

-- Clipboard and emoji picker
hl.bind("SUPER + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
hl.bind("SUPER + ALT + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard -d"))
hl.bind("CTRL + SHIFT + ALT + V", hl.dsp.exec_cmd("sleep 0.5s && ydotool type -d 1 \"$(cliphist list | head -1 | cliphist decode)\""), { locked = true })

-- Previous workspace
hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Testing
hl.bind("SUPER + ALT + f12", hl.dsp.exec_cmd("notify-send -u low -i dialog-information-symbolic 'Test notification' \"Here's a really long message to test truncation and wrapping\\nYou can middle click or flick this notification to dismiss it!\" -a 'Shell' -A \"Test1=I got it!\" -A \"Test2=Another action\""), { locked = true })

-- end) -- end define_submap
