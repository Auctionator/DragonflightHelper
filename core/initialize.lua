local _, ns = ...

SLASH_DFH_TOGGLE1 = "/dfh"

ns.media = {}

ns.events = {}
ns.config = {}
ns.theme = {}

ns.components = {}
ns.components.helpers = {}

ns.panels = {}

ns.factions = {}
ns.timers = {}

ns.debug = {}

if DRAGONFLIGHT_HELPER_CONFIG == nil then
  DRAGONFLIGHT_HELPER_CONFIG = {}
end

if DRAGONFLIGHT_HELPER_CONFIG.theme == nil then
  DRAGONFLIGHT_HELPER_CONFIG.theme = {}
end
