-- Startup exec commands
local vars = require("variables")

-- Use hyprland.start event for autostart (exec-once equivalent)
hl.on("hyprland.start", function()
  -- Keyring and auth
  hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
  hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

  -- Clipboard history
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")

  -- Auto delete trash 30 days old
  hl.exec_cmd("trash-empty 30")

  -- Cursors
  hl.exec_cmd("hyprctl setcursor " .. vars.cursorTheme .. " " .. tostring(vars.cursorSize))
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme '" .. vars.cursorTheme .. "'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. tostring(vars.cursorSize))

  -- Location provider and night light
  hl.exec_cmd("/usr/lib/geoclue-2.0/demos/agent")
  hl.exec_cmd("sleep 1 && gammastep")

  -- Forward bluetooth media commands to MPRIS
  hl.exec_cmd("mpris-proxy")

  -- Network manager tray applet (captive portal support)
  hl.exec_cmd("nm-applet")

  -- Bluetooth tray applet
  hl.exec_cmd("blueman-applet")

  -- Resize and move windows based on matches (e.g. pip)
  hl.exec_cmd("caelestia resizer -d")

  -- Start shell
  hl.exec_cmd("caelestia shell -d")

  -- Alt-tab window switcher (uncomment to enable)
  -- hl.exec_cmd("hyprshell run")

  -- Auto-dim unfocused windows (uncomment to enable)
  -- hl.exec_cmd("hyprdim")

  -- Bootstrap Caelestia configs (configs.fish)
  hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/configs.fish " .. os.getenv("HOME") .. "/.config/caelestia")
end)
