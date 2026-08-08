-- Window group settings
local vars = require("variables")
local colors = require("scheme/current")

local function rgba(hex, alpha)
  if alpha then
    return "rgba(" .. hex .. alpha .. ")"
  end
  return "rgba(" .. hex .. ")"
end

hl.config({
  group = {
    col = {
      border_active = rgba(colors.primary, "e6"),
      border_inactive = rgba(colors.onSurfaceVariant, "11"),
      border_locked_active = rgba(colors.primary, "e6"),
      border_locked_inactive = rgba(colors.onSurfaceVariant, "11"),
    },
    groupbar = {
      font_family = "JetBrains Mono NF",
      font_size = 15,
      gradients = true,
      gradient_round_only_edges = false,
      gradient_rounding = 5,
      height = 25,
      indicator_height = 0,
      gaps_in = 3,
      gaps_out = 3,
      text_color = "rgb(" .. colors.onPrimary .. ")",
      col = {
        active = rgba(colors.primary, "d4"),
        inactive = rgba(colors.outline, "d4"),
        locked_active = rgba(colors.primary, "d4"),
        locked_inactive = rgba(colors.secondary, "d4"),
      },
    },
  },
})
