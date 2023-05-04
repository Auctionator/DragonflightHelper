local addon, ns = ...
local helpers = ns.components.helpers
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media
local log = ns.debug.log

function helpers:create_expanding_frame(parent_frame, child_specs)
  local id = self:get_id()

  local frame = CreateFrame("Frame", addon .. "_expanding_frame_" .. id, parent_frame)
  frame:SetHeight(2)

  local start_frame = CreateFrame("Frame", addon .. "_expanding_frame_start_" .. id, frame)
  start_frame:SetHeight(1)
  start_frame:SetPoint("TOPLEFT")
  start_frame:SetPoint("RIGHT")

  -- local end_frame = CreateFrame("Frame", addon .. "_expanding_frame_end_" .. id, frame)
  -- end_frame:SetHeight(1)
  -- end_frame:SetPoint("BOTTOMLEFT")
  -- end_frame:SetPoint("RIGHT")

  frame.child_specs = child_specs

  local previous = start_frame

  for key, spec in pairs(child_specs) do
    print(key, spec.display)
    spec.component:SetParent(frame)

    spec.component:ClearAllPoints()
    spec.component:SetPoint("TOP", previous, "BOTTOM")
    spec.component:SetPoint("RIGHT", frame, "RIGHT")
    spec.component:SetPoint("LEFT", frame, "LEFT")

    if spec.display then
      previous = spec.component
      frame:SetHeight(frame:GetHeight() + spec.component:GetHeight())
    else
      spec:Hide()
    end
  end

  -- end_frame:SetPoint("TOP", previous, "BOTTOM")

  return frame
end
