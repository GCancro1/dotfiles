-- ╔═══════════════════════════════════════════════════════════════╗
-- ║  Hyprland Lua Configuration (v0.55+)                       ║
-- ║  Migrated from hyprlang (.conf) for testing                 ║
-- ║  Launch: Hyprland --config ~/.config/hypr-lua/hyprland.lua  ║
-- ╚═══════════════════════════════════════════════════════════════╝

-- Set up package path so require() works from this directory
local configDir = os.getenv("HOME") .. "/.config/hypr-lua/"
package.path = configDir .. "?.lua;" .. configDir .. "?/init.lua;" .. package.path

-- ── Core modules ───────────────────────────────────────────────
local variables = require("variables")
local colors    = require("scheme/current")

-- ── Caelestia user overrides (inline from hypr-user.conf) ──────
-- Caelestia uses .conf format which can't be require()'d in Lua.
-- We inline the relevant overrides here. Edit this section when
-- hypr-user.conf changes.
hl.on("hyprland.start", function()
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("blueman-applet")
end)
hl.bind("CTRL + ALT + V", hl.dsp.exec_cmd("pavucontrol"))

-- ── Load all modules ───────────────────────────────────────────
require("modules/env")
require("modules/general")
require("modules/input")
require("modules/misc")
require("modules/decoration")
require("modules/animations")
require("modules/group")
require("modules/execs")
require("modules/rules")
require("modules/gestures")
require("modules/keybinds")
require("modules/scrolling")

-- ── Monitors ───────────────────────────────────────────────────
require("monitors")
