local addon, ns = ...
local helpers = ns.components.helpers
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media
local theme = ns.theme

function helpers:create_checkbox(options)
  local container_name = addon .. "_check_container_" .. self:get_id()

  if options == nil then
    options = {}
  end

  local parent_frame = options.parent or UIParent
  local text = options.text or ""
  local checked = options.checked or false
  local handler = options.handler or function(_)
  end

  local frame = CreateFrame("FRAME", container_name, parent_frame)
  frame:SetHeight(15)

  local checkbox = CreateFrame("Button", addon .. "_check_button_" .. self:get_id(), frame)
  checkbox:SetHeight(15)
  checkbox:SetWidth(15)
  checkbox:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, 2)
  self:add_border(checkbox)

  local title = helpers:create_title_string(frame, media:get_font_object(theme:get_font()), text)
  title:ClearAllPoints()
  title:SetPoint("TOPLEFT", frame, "TOPLEFT", 22, 2)
  title:SetPoint("RIGHT", frame, "RIGHT", -2)
  title:SetPoint("BOTTOM", frame, "BOTTOM")
  title:SetJustifyH("LEFT")
  title:SetJustifyV("MIDDLE")

  local background_texture_on = checkbox:CreateTexture()
  background_texture_on:SetPoint("TOPLEFT", checkbox, "TOPLEFT", 3, -3)
  background_texture_on:SetPoint("BOTTOMRIGHT", checkbox, "BOTTOMRIGHT", -3, 3)
  local on = ITEM_QUALITY_COLORS[2]
  background_texture_on:SetColorTexture(on.r, on.g, on.b, on.a)

  local background_texture_off = checkbox:CreateTexture()
  background_texture_off:SetPoint("TOPLEFT", checkbox, "TOPLEFT", 3, -3)
  background_texture_off:SetPoint("BOTTOMRIGHT", checkbox, "BOTTOMRIGHT", -3, 3)
  local off = FACTION_BAR_COLORS[1]

  background_texture_off:SetColorTexture(off.r, off.g, off.b, 1)

  checkbox:SetScript("OnClick", function()
    checked = not checked
    handler(checked)

    if checked then
      background_texture_on:Show()
      background_texture_off:Hide()
    else
      background_texture_on:Hide()
      background_texture_off:Show()
    end
  end)

  if checked then
    background_texture_on:Show()
    background_texture_off:Hide()
  else
    background_texture_on:Hide()
    background_texture_off:Show()
  end

  return frame
end
