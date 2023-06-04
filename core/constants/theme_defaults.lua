local _, ns = ...

local SECTIONS = ns.constants.SECTIONS
local SKILL_SUBSECTIONS = ns.constants.SKILL_SUBSECTIONS

ns.constants.DEFAULT_THEME = {
  [SECTIONS.FACTIONS] = {
    order = 1,
    name = SECTIONS.FACTIONS,
    display = true,
    subsections = {
      [2507] = { display = true },
      [2503] = { display = true },
      [2511] = { display = true },
      [2510] = { display = true },
      [2564] = { display = true },
    }
  },
  [SECTIONS.FRIENDS] = {
    order = 2,
    name = SECTIONS.FRIENDS,
    display = true,
    subsections = {
      [2544] = { display = true },
      [2550] = { display = true },
      [2518] = { display = true },
      [2517] = { display = true },
    }
  },
  [SECTIONS.TIMERS] = {
    order = 3,
    name = SECTIONS.TIMERS,
    display = true,
    subsections = {
      Feast = { display = true },
      Siege = { display = true },
    }
  },
  [SECTIONS.TODOS] = {
    order = 4,
    name = SECTIONS.TODOS,
    display = true,
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
  [SECTIONS.PROFESSIONS_ONE] = {
    order = 5,
    name = SECTIONS.PROFESSIONS_ONE,
    display = true,
    subsections = {
      [SKILL_SUBSECTIONS.Treatise] = { display = true, order = 1 },
      [SKILL_SUBSECTIONS.Gathering] = { display = true, order = 1 },
      [SKILL_SUBSECTIONS.Trainer] = { display = true, order = 1 },
      [SKILL_SUBSECTIONS.MobDrops] = { display = true, order = 1 },
      [SKILL_SUBSECTIONS.Azley] = { display = true, order = 1 },
      [SKILL_SUBSECTIONS.Weekly] = { display = true, order = 1 },
    }
  },
  [SECTIONS.PROFESSIONS_TWO] = {
    order = 6,
    name = SECTIONS.PROFESSIONS_TWO,
    display = true,
    subsections = {
      [SKILL_SUBSECTIONS.Treatise] = { display = true, order = 1 },
      [SKILL_SUBSECTIONS.Gathering] = { display = true, order = 1 },
      [SKILL_SUBSECTIONS.Trainer] = { display = true, order = 1 },
      [SKILL_SUBSECTIONS.MobDrops] = { display = true, order = 1 },
      [SKILL_SUBSECTIONS.Azley] = { display = true, order = 1 },
      [SKILL_SUBSECTIONS.Weekly] = { display = true, order = 1 },
    }
  }
}
