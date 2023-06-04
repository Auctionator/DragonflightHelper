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

  if setup_info.click_function then
    statusbar.button:SetScript("OnClick", setup_info.click_function)
  end

  return statusbar
end

ns.professions.create_profession_statusbar = create_profession_statusbar
