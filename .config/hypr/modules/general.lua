-- General settings
local vars = require("variables")
local colors = require("scheme/current")

-- Helper for rgba with alpha
local function rgba(hex, alpha)
  if alpha then
    return "rgba(" .. hex .. alpha .. ")"
  end
  return "rgba(" .. hex .. ")"
end

hl.config({
  general = {
    layout = "dwindle",
    allow_tearing = false,
    gaps_workspaces = vars.workspaceGaps,
    gaps_in = vars.windowGapsIn,
    gaps_out = vars.windowGapsOut,
    border_size = vars.windowBorderSize,
    col = {
      active_border = rgba(colors.primary, "e6"),
      inactive_border = rgba(colors.onSurfaceVariant, "11"),
    },
  },
  dwindle = {
    preserve_split = true,
    smart_split = false,
    smart_resizing = true,
  },
})
