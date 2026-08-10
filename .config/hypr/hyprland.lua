-- ╔═══════════════════════════════════════════════════════════════╗
-- ║  Hyprland Lua Configuration (v0.55+)                       ║
-- ║  Migrated from hyprlang (.conf)                             ║
-- ╚═══════════════════════════════════════════════════════════════╝

-- Set up package path so require() works from this directory
local configDir = os.getenv("HOME") .. "/.config/hypr/"
package.path = configDir .. "?.lua;" .. configDir .. "?/init.lua;" .. package.path

-- ── Core modules ───────────────────────────────────────────────
local variables = require("variables")
local colors    = require("scheme/current")

-- ── Caelestia user overrides ───────────────────────────────────

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
