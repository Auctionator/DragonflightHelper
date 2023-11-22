local addon, ns = ...
local log = ns.debug.log
local helpers = ns.components.helpers
local media = ns.media
local theme = ns.theme

local ELEMENT_PADDING_Y = 3
local ELEMENT_PADDING_X = 3

function helpers:create_auto_sizing_frame(parent, title_text, frame_enabled)
  local frame_name = addon .. "_auto_sizing_frame_" .. self:get_id()

  local frame = CreateFrame("FRAME", frame_name, parent)
  frame:SetHeight(0.1)
  frame.children = {}

  function frame:recalculate_height()
    self:SetHeight(0.1)

    for index, child in ipairs(frame.children) do
      -- not sure if font string's get height method will return correctly here...
      log(nil, "recalculate_height", 1, "h", frame_name .. " " .. title_text .. " " .. self:GetHeight())
      self:SetHeight(self:GetHeight() + (child.visible and (child.initial_height + ELEMENT_PADDING_Y) or 0))
    end
  end

  function frame:add(child, visible)
    if child:GetHeight() == 0 then
      log("ERROR", "ui", 1, ("Adding child to %s with height of 0"):format(frame_name))
    end

    child:SetParent(frame)
    child:ClearAllPoints()

    if #frame.children ~= 0 then
      child:SetPoint("TOPLEFT", frame.children[#frame.children].element, "BOTTOMLEFT", 0, -1 * ELEMENT_PADDING_Y)
      child:SetPoint("RIGHT", frame.children[#frame.children].element, "RIGHT")
    else
      child:SetPoint("TOPLEFT", frame, "TOPLEFT", ELEMENT_PADDING_X, -1 * ELEMENT_PADDING_Y)
      child:SetPoint("RIGHT", frame, "RIGHT", -1 * ELEMENT_PADDING_X)
    end

    table.insert(frame.children, {
      element = child,
      visible = visible,
      initial_height = child:GetHeight()
    })
    if visible then
      child:Show()
    else
      child:Hide()
      child:SetHeight(0)
    end

    frame:recalculate_height()

    return #frame.children
  end

  if title_text then
    local title = helpers:create_title_string(frame, media:get_font_object(theme:get_font()), title_text)
    frame.title = title

    title:SetHeight(title:GetStringHeight())

    frame:add(title, frame_enabled)
  end

  function frame:show_child(child_index)
    frame.children[child_index].visible = true
    frame.children[child_index]:SetHeight(frame.children[child_index].initial_height)
    frame.children[child_index]:Show()

    frame:recalculate_height()
  end

  function frame:hide_child(child_index)
    frame.children[child_index].visible = false
    frame.children[child_index]:SetHeight(0)
    frame.children[child_index]:Hide()

    frame:recalculate_height()
  end

  return frame
end
