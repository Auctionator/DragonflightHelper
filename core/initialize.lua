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

ns.constants = {}

if DRAGONFLIGHT_HELPER_CONFIG == nil then
  DRAGONFLIGHT_HELPER_CONFIG = {}
end


ns.constants.SECTIONS = {
  FACTIONS = "Factions",
  FRIENDS = "Friends",
  TIMERS = "Timers",
  TODOS = "Todos",
  PROFESSIONS_ONE = "Profession One",
  PROFESSIONS_TWO = "Professions Two"
}

ns.constants.DEFAULT_THEME = {
  SECTIONS = {
    {
      name = ns.constants.SECTIONS.FACTIONS,
      display = true,
      get_subsection_name = function(id)
        return id
      end,
      subsections = {
        [2507] = { display = true },
        [2503] = { display = true },
        [2511] = { display = true },
        [2510] = { display = true },
      }
    },
    {
      name = ns.constants.SECTIONS.FRIENDS,
      display = true,
      get_subsection_name = function(id) return id end,
      subsections = {
        [2544] = { display = true },
        [2550] = { display = true },
        [2518] = { display = true },
        [2517] = { display = true },
      }
    },
    {
      name = ns.constants.SECTIONS.TIMERS,
      display = true,
      get_subsection_name = function(id) return id end,
      subsections = {
        Feast = { display = true },
        Siege = { display = true },
      }
    },
    {
      name = ns.constants.SECTIONS.TODOS,
      display = true,
      get_subsection_name = function(id) return id end,
      subsections = {
        Aiding = { display = true },
        Catalyst = { display = true },
        Feast = { display = true },
        Siege = { display = true },
        Hunts = { display = true },
        Flood = { display = true },
        Elements = { display = true },
        Bosses = { display = true },
      }
    },
    {
      name = ns.constants.SECTIONS.PROFESSIONS_ONE,
      display = true,
      get_subsection_name = function(id) return id end,
      subsections = {
        Treatise = { display = true },
        Gathering = { display = true },
        Trainer = { display = true },
        MobDrops = { display = true },
        Azley = { display = true },
        Weekly = { display = true },
      }
    },
    {
      name = ns.constants.SECTIONS.PROFESSIONS_TWO,
      display = true,
      get_subsection_name = function(id) return id end,
      subsections = {
        Treatise = { display = true },
        Gathering = { display = true },
        Trainer = { display = true },
        MobDrops = { display = true },
        Azley = { display = true },
        Weekly = { display = true },
      }
    }
  }
}

if DRAGONFLIGHT_HELPER_CONFIG.theme == nil then
  DRAGONFLIGHT_HELPER_CONFIG.theme = ns.constants.DEFAULT_THEME
end
