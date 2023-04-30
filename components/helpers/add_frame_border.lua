local _, ns = ...
local helpers = ns.components.helpers

local BORDERS = {
  { "TOPLEFT",     "TOPRIGHT" },
  { "TOPRIGHT",    "BOTTOMRIGHT" },
  { "BOTTOMRIGHT", "BOTTOMLEFT" },
  { "BOTTOMLEFT",  "TOPLEFT" }
}

function helpers:add_border(frame, options)
  local thickness = (options and options.thickness) or 1
  local r = (options and options.r) or (112 / 256)
  local g = (options and options.g) or (128 / 256)
  local b = (options and options.b) or (144 / 256)
  local a = (options and options.a) or 1

  frame.borders = {}
  for i = 1, 4 do
    local line = frame:CreateLine(nil, "BACKGROUND", nil, 0)
    line:SetThickness(thickness)
    line:SetColorTexture(r, g, b, a)

    frame.borders[i] = line
    line:SetStartPoint(BORDERS[i][1])
    line:SetEndPoint(BORDERS[i][2])
  end
end
