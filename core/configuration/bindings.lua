local _, ns = ...
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local theme = ns.theme
local log = ns.debug.log

DragonflightHelperAddonKeyBindings = {}

function DragonflightHelperAddonKeyBindings.ToggleBinding()
  log(nil, "bindings", 1, "current", theme:get_is_showing())
  log(nil, "bindings", 1, "next", not theme:get_is_showing())

  event_manager:handle(custom_events.FRAME_SHOWING_CHANGED, not theme:get_is_showing())
end
