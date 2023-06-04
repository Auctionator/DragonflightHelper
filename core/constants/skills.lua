local _, ns = ...

local SKILL_IDS = {
  Alchemy = 171,
  Blacksmithing = 164,
  Enchanting = 333,
  Engineering = 202,
  Herbalism = 182,
  Inscription = 773,
  Jewelcrafting = 755,
  Leatherworking = 165,
  Mining = 186,
  Skinning = 393,
  Tailoring = 197
}

ns.constants.professions = {}
ns.constants.map_ids = {
  WakingShore = 2022,
  OhnAhranPlains = 2023,
  AzureSpan = 2024,
  Thaldraszus = 2025,
  Valdrakken = 2112 -- Need to verify this
}

ns.constants.professions.SKILL_CURRENCIES = {
  [SKILL_IDS.Herbalism] = 2034,      -- Herbalism
  [SKILL_IDS.Mining] = 2035,         -- Mining
  [SKILL_IDS.Skinning] = 2033,       -- Skinning
  [SKILL_IDS.Alchemy] = 2024,        -- Alchemy
  [SKILL_IDS.Blacksmithing] = 2023,  -- Blacksmithing
  [SKILL_IDS.Enchanting] = 2030,     -- Enchanting
  [SKILL_IDS.Engineering] = 2027,    -- Engineering
  [SKILL_IDS.Inscription] = 2028,    -- Inscription
  [SKILL_IDS.Jewelcrafting] = 2029,  -- Jewelcrafting
  [SKILL_IDS.Leatherworking] = 2025, -- Leatherworking
  [SKILL_IDS.Tailoring] = 2026,      -- Tailoring
}

ns.constants.professions.SKILL_IDS = SKILL_IDS
