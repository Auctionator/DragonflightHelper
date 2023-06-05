local _, ns = ...

local components = ns.components
local media = ns.media
local theme = ns.theme

local function create_profession_statusbar(parent, profession_data, subsection_id, subsection)
  local font_object = media:get_font_object(theme:get_font())
  local statusbar_texture = theme:get_statusbar()
  local setup_info = ns.professions.setup[subsection_id](profession_data)

  if not (setup_info.is_valid_subsection) then
    return nil
  end

  local on_quest = setup_info.currently_on_quest()

  local statusbar = components.helpers:create_status_bar({
    parent = parent,
    font_object = font_object,
    statusbar_texture = statusbar_texture,
    visible = subsection.display,
    title = setup_info.title,
    events = setup_info.events,
    notify = setup_info.notify_function,
    color = theme:get_completed_quest_color(),
    background_color = on_quest and theme:get_accepted_quest_color() or theme:get_incomplete_quest_color(),
    max = setup_info.max,
    value = setup_info.completed_count,
    description = ("%d/%d"):format(setup_info.completed_count, setup_info.max)
  })

  statusbar:SetParent(parent)

  if setup_info.tooltip_function then
    statusbar.button:SetScript("OnEnter", setup_info.tooltip_function)
    statusbar.button:SetScript("OnLeave", function()
      GameTooltip:Hide()
    end)
  end

  statusbar.button:RegisterForClicks("AnyUp")

  -- local context_menu = CreateFrame("Frame", nil, statusbar.button, "UIDropDownMenuTemplate")

  -- UIDropDownMenu_Initialize(context_menu, function()
  --   local info = UIDropDownMenu_CreateInfo()
  --   info.text = "Select color"

  --   info.hasColorSwatch = true
  --   info.r = 1
  --   info.g = 0
  --   info.b = 0
  --   info.opacity = 0.4
  --   info.hasOpacity = true

  --   info.swatchFunc = function(...)
  --     local r, g, b = ColorPickerFrame:GetColorRGB()
  --     local a = OpacitySliderFrame:GetValue()
  --     print(..., r, g, b, a)
  --   end

  --   UIDropDownMenu_AddButton(info)
  -- end)

  statusbar.button:SetScript("OnClick", function(...)
    local _, button = ...

    -- if button == "RightButton" then
    --   ToggleDropDownMenu(1, nil, context_menu, statusbar.button, 0, 0)
    -- end

    if setup_info.click_function and button ~= "RightButton" then
      setup_info.click_function(...)
    end
  end)

  return statusbar
end

ns.professions.create_profession_statusbar = create_profession_statusbar
