-- Animation configuration
-- ══════════════════════════════════════════════════════════════════
-- ANIMATION SPEED MULTIPLIER
-- Change this single value to scale ALL animation speeds.
--   1 = normal, 2 = fast, 3 = faster, 4 = ultra fast
-- ══════════════════════════════════════════════════════════════════
local ANIM_SPEED_MULT = 1

-- Base speeds (at 1x multiplier) — these are the "normal" speeds
-- Order: layersIn, layersOut, fadeLayers, windowsIn, windowsOut,
--        windowsMove, workspaces, specialWorkspace, fade, fadeDim, border
local BASE_SPEEDS = {
  layersIn       = 6,
  layersOut      = 4,
  fadeLayers     = 6,
  windowsIn      = 6,
  windowsOut     = 4,
  windowsMove    = 6,
  workspaces     = 6,
  specialWorkspace = 4,
  fade           = 6,
  fadeDim        = 6,
  border         = 6,
}

-- Helper: apply multiplier and ensure minimum of 1
local function speed(name)
  return math.max(1, math.floor(BASE_SPEEDS[name] / ANIM_SPEED_MULT + 0.5))
end

-- ── Curves ──────────────────────────────────────────────────────
hl.curve("specialWorkSwitch", {
  type = "bezier",
  points = { { 0.05, 0.7 }, { 0.1, 1 } },
})

hl.curve("emphasizedAccel", {
  type = "bezier",
  points = { { 0.3, 0 }, { 0.8, 0.15 } },
})

hl.curve("emphasizedDecel", {
  type = "bezier",
  points = { { 0.05, 0.7 }, { 0.1, 1 } },
})

hl.curve("standard", {
  type = "bezier",
  points = { { 0.2, 0 }, { 0, 1 } },
})

-- ── Animations ──────────────────────────────────────────────────
hl.config({
  animations = {
    enabled = true,
  },
})

-- Layers
hl.animation({ leaf = "layersIn",       enabled = true, speed = speed("layersIn"),       bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "layersOut",      enabled = true, speed = speed("layersOut"),      bezier = "emphasizedAccel", style = "slide" })
hl.animation({ leaf = "fadeLayersIn",   enabled = true, speed = speed("fadeLayers"),     bezier = "standard" })
hl.animation({ leaf = "fadeLayersOut",  enabled = true, speed = speed("fadeLayers"),     bezier = "standard" })

-- Windows
hl.animation({ leaf = "windowsIn",      enabled = true, speed = speed("windowsIn"),      bezier = "emphasizedDecel" })
hl.animation({ leaf = "windowsOut",     enabled = true, speed = speed("windowsOut"),     bezier = "emphasizedAccel" })
hl.animation({ leaf = "windowsMove",    enabled = true, speed = speed("windowsMove"),    bezier = "standard" })

-- Workspaces
hl.animation({ leaf = "workspaces",     enabled = true, speed = speed("workspaces"),     bezier = "standard" })

-- Special workspace
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = speed("specialWorkspace"), bezier = "specialWorkSwitch", style = "slidefadevert 15%" })

-- Fades
hl.animation({ leaf = "fade",           enabled = true, speed = speed("fade"),           bezier = "standard" })
hl.animation({ leaf = "fadeDim",        enabled = true, speed = speed("fadeDim"),        bezier = "standard" })

-- Border
hl.animation({ leaf = "border",         enabled = true, speed = speed("border"),         bezier = "standard" })

-- Export the multiplier so other modules can reference it if needed
return { ANIM_SPEED_MULT = ANIM_SPEED_MULT }
