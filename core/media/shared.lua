local _, ns = ...
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local log = ns.debug.log

ns.media.shared = LibStub("LibSharedMedia-3.0")

local listener = CreateFrame("Frame")

function listener:init()
  ns.media.shared.RegisterCallback(self, "LibSharedMedia_Registered", function(_, mediatype, key)
    log(nil, "shared", 1, "register", mediatype .. ":" .. key)

    if mediatype == "statusbar" then
      event_manager:handle(custom_events.NEW_STATUSBAR_AVAILABLE, key, ns.media.shared:Fetch(mediatype, key))
    elseif mediatype == "font" then
      event_manager:handle(custom_events.NEW_FONT_AVAILABLE, key, ns.media.shared:Fetch(mediatype, key))
    end
  end)
end

listener:init()
