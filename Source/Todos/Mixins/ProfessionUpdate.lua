DFH_ProfessionUpdate = CreateFromMixins(DFH_GenericUpdate)

local SkillIds = {
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

local ProfessionQuests = {
  Treatise = {
    title = "Draconic Treatise",
    [SkillIds.Alchemy] = { quests = { 74108 } },
    [SkillIds.Blacksmithing] = { quests = { 74109 } },
    [SkillIds.Enchanting] = { quests = { 74110 } },
    [SkillIds.Engineering] = { quests = { 74111 } },
    [SkillIds.Herbalism] = { quests = { 74107 } },
    [SkillIds.Inscription] = { quests = { 74105 } },
    [SkillIds.Jewelcrafting] = { quests = { 74112 } },
    [SkillIds.Leatherworking] = { quests = { 74113 } },
    [SkillIds.Mining] = { quests = { 74106 } },
    [SkillIds.Skinning] = { quests = { 74114 } },
    [SkillIds.Tailoring] = { quests = { 74115 } },
  },
  Gathering = {
    -- TODO Guessed on order of these relative to quests... (I assume they match in increasing order)
    [SkillIds.Herbalism] = { title = "Dreambloom", quests = { 71857, 71858, 71859, 71860, 71861, 71864 } },
    [SkillIds.Mining] = { title = "Iridescent Ore", quests = { 72160, 72161, 72162, 72163, 72164, 72165 } },
    [SkillIds.Skinning] = { title = "Curious Hide", quests = { 70381, 70383, 70384, 70385, 70386, 70389 } },
    [SkillIds.Alchemy] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66373, 66374 }, items = { 193891, 193897 } },
    [SkillIds.Blacksmithing] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66381, 66382 }, items = { 192131, 192132 } },
    [SkillIds.Enchanting] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66377, 66378 }, items = { 193900, 193901 } },
    [SkillIds.Engineering] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66379, 66380 }, items = { 193902, 193903 } },
    [SkillIds.Inscription] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66375, 66376 }, items = { 193904, 193905 } },
    [SkillIds.Jewelcrafting] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66388, 66389 }, items = { 193907, 193909 } },
    [SkillIds.Leatherworking] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66384, 66385 }, items = { 193910, 193913 } },
    [SkillIds.Tailoring] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66386, 66387 }, items = { 193899, 193898 } },
  },
  ValdrakkenRabul = {
    title = "Rabul <Artisan's Consortium Quartermaster>",
    -- Like treatises only single use (i.e. not weekly for future me!); figure out quest ID
    [SkillIds.Herbalism] = { quests = { 71897 }, items = { 200980 } }
  },
  -- Crafting professions get: (minimum profession level requirement is 25)
  -- * 1 weekly “fulfill x craft orders” quest from the NPC near crafting order placing area (Azley)
  -- * 1 weekly “loot x items from y mobs” quest also from NPCs near crafting order placing area and (Dhurrel/Temnaayu)
  -- * 1 weekly “craft x low level items and turn in” quest from that crafting profession’s trainer.

  -- Gathering professions get:
  -- * 6 profession knowledge items as random drops while gathering, as well as 1 epic gathering drop.
  -- * 1 weekly “gather x items at y quality” quest near the crafting order area and
  -- * 1 weekly “gather x items” quest from that gathering profession’s trainer.
  ValdrakkenServicesAzley = {
    title = "Azley <Artisan's Consortium>",
    description = "Weekly Services Requested'",
    [SkillIds.Leatherworking] = { quests = { 70594 } },
    [SkillIds.Tailoring] = { quests = { 70595 } },
    [SkillIds.Jewelcrafting] = { quests = { 70593 } },
    [SkillIds.Blacksmithing] = { quests = { 70589 } },
    [SkillIds.Engineering] = { quests = { 70591 } },
    [SkillIds.Inscription] = { quests = { 70592 } },
  },
  ValdrakkenTrainers = {
    [SkillIds.Alchemy] = { title = "Conflago <Trainer>", quests = { 70532, 70533, 70530, 70531 }, completionCount = 1 },
    [SkillIds.Blacksmithing] = { title = "Metalshaper Kuroko <Trainer>", quests = { 70234, 70233, 70235, 70211 }, completionCount = 1 },
    [SkillIds.Enchanting] = { title = "Soragosa <Trainer>", quests = { 72175, 72173, 72172, 72155 }, completionCount = 1 },
    [SkillIds.Engineering] = { title = "Clinkyclick Shatterboom <Trainer>", quests = { 70540, 70539, 70545, 70557 }, completionCount = 1 },
    [SkillIds.Herbalism] = { title = "Agrikus <Trainer>", quests = { 70614, 70613, 70616 }, completionCount = 1 },
    [SkillIds.Inscription] = { title = "Talendara <Trainer>", quests = { 70561, 70558, 70559, 70560 }, completionCount = 1 },
    [SkillIds.Jewelcrafting] = { title = "Tuluradormi <Trainer>", quests = { 70565, 70564, 70563, 70562 }, completionCount = 1 },
    [SkillIds.Leatherworking] = { title = "Hideshaper Koruz <Trainer>", quests = { 70571, 70569, 70568, 70567 }, completionCount = 1 },
    [SkillIds.Mining] = { title = "Sekita the Burrower <Trainer>", quests = { 72156, 70617, 70618, 72157 }, completionCount = 1 },
    [SkillIds.Skinning] = { title = "Ralathor the Rugged <Trainer>", quests = { 72158, 70619, 72159, 70620 }, completionCount = 1 },
    [SkillIds.Tailoring] = { title = "Threadfinder Fulafong <Trainer>", quests = { 70587, 70586, 70572, 70582 }, completionCount = 1 },
  },
  Valdrakken = {
    title = "Valdrakken Weekly Profession",

    [SkillIds.Alchemy] = { completionCount = 1, quests = {
      -- Dhurrel <Trade Liaison>
      72427, 66940, 66938,
      -- Dothenos <Trade Coordinator>
      66937
    } },

    [SkillIds.Leatherworking] = { completionCount = 1, quests = {
      -- Dhurrel <Trade Liaison>
      66363,
      -- Temnaayu <Trade Negotiator>
      66951, 72407, 66364
    } },

    [SkillIds.Blacksmithing] = { completionCount = 1, quests = {
      -- Dhurrel <Trade Liaison>
      66517, 66897, 66941
    } },

    [SkillIds.Jewelcrafting] = { completionCount = 1, quests = {
      -- Temnaayu <Trade Negotiator>
      66950, 66949,
      -- Gnoklin Quirkcoil <Requisitions Officer>
      72428, 66516
    } },

    [SkillIds.Enchanting] = { completionCount = 1, quests = {
      -- Temnaayu <Trade Negotiator>
      66900, 66884, 72423,
      -- Gnoklin Quirkcoil <Requisitions Officer>
      66935
    } },

    [SkillIds.Tailoring] = { completionCount = 1, quests = {
      -- Dothenos <Trade Coordinator>
      66952,
      -- Gnoklin Quirkcoil <Requisitions Officer>
      72410
    } },

    [SkillIds.Engineering] = { completionCount = 1, quests = {
      -- Dothenos <Trade Coordinator>
      72396, 66890,
      -- Gnoklin Quirkcoil <Requisitions Officer>
      66942, 66891
    } },

    [SkillIds.Inscription] = { completionCount = 1, quests = {
      -- Dothenos <Trade Coordinator>
      66945, 72438, 66943,
      -- Gnoklin Quirkcoil <Requisitions Officer>
      66944
    } },
  },
  WeeklyDrops = {
    title = "Weekly Mob Drops",

    [SkillIds.Alchemy] = {
      quests = { 70511, 70504 },
      items = { 198964, 198963 },
      descriptions = { "/way #2022 52.2 56.2 Encroaching Downpour", "/way #2024 17.78 39.22 Brakenhide Rotflinger" }
    },
    [SkillIds.Leatherworking] = { quests = { 70523, 70522 }, items = { 198975, 198976 }, descriptions = { "/way 80 24 Primal Proto-Drakes", "/way The Azure Span:Dragon Isles 38 31 Vorquin Farm Spot" } },
    [SkillIds.Tailoring] = { quests = { 70524, 70525 }, items = { 198977, 198978 }, descriptions = { "/way Ohn'ahran Plains 84 56", "/way The Azure Span:Dragon Isles 33.84 47.22" } },
    [SkillIds.Jewelcrafting] = { quests = { 70521, 70520 }, items = { 198974, 198973 }, descriptions = { "/way #2025 45.0 55.4 Rebel Bruiser", "/way The Waking Shores 52.5 32.5 Crushing Elementals" } },
    [SkillIds.Blacksmithing] = { quests = { 70513, 70512 }, items = { 198966, 198965 }, descriptions = { "/way #2022 37.8 73.0 Blazing Manifestation", "/way #2022 46.35 37.26 Crushing Elementals" } },
    [SkillIds.Engineering] = { quests = { 70516, 70517 }, items = { 198969, 198970 }, descriptions = { "/way #2025 57.0 59.2 Titan Defense Matrix", "/way #2025 45.8 58.2 Rebel Bruiser" } },
    [SkillIds.Inscription] = { quests = { 70518, 70519 }, items = { 198971, 198972 }, descriptions = { "/way #2022 37.2 63.4 Qalashi Necksnapper", "/way #2024 66.4 59.4 Arcane Manipulators" } },
    [SkillIds.Enchanting] = { quests = { 70514, 70515 }, items = { 198967, 198968 }, descriptions = { " /way #2024 39.2 64.0 Mana Wyrmling, Stabilized Elementals", "/way #2025 53.2 65.6 Earthshaker Marauder" } },
  }
}

function DFH_ProfessionUpdate:CollapseFrame()
  self:Hide()
  self:SetHeight(1)

  -- This should be "TOPLEFT"
  local point, relativeTo, relativePoint = self:GetPoint()
  self:SetPoint(point, relativeTo, relativePoint, 0, 1)
  self.collapsed = true
end

function DFH_ProfessionUpdate:Update()
  self.collapsed = false

  if self.professionIndex == nil then
    DragonflightHelper.Utilities.error("[INCORRECT USAGE]", "DFH_ProfessionUpdate: A professionIndex must be provided")
    self:SetTitle("Unknown profession")
    return
  end

  if not self:hasProfession(self.professionIndex) then
    self:SetTitle("No profession selected")
    return
  end

  if self.questTypeKey == nil then
    DragonflightHelper.Utilities.error("[INCORRECT USAGE]",
      "DFH_ProfessionUpdate: A questTypeKey object must be initialized")
    self:SetForegroundColor(0, 0, 0, 0)
    return
  end

  if ProfessionQuests[self.questTypeKey] == nil then
    self:CollapseFrame()
    return
  end

  if ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)] == nil then
    self:CollapseFrame()
    return
  end

  local entry = ProfessionQuests[self.questTypeKey]

  if ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)].items ~= nil then
    self.items = ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)].items

    self:SetEnterCallback(function()
      self:ShowItemsTooltip(entry[self:getId(self.professionIndex)], entry.title)
    end)

    self:SetLeaveCallback(function()
      GameTooltip:Hide()
    end)
  end

  DFH_GenericUpdate.update(self, entry[self:getId(self.professionIndex)], entry.title)
end

function DFH_ProfessionUpdate:ShowItemsTooltip(entry, optionalTitle)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

  GameTooltip_SetTitle(GameTooltip,
    (optionalTitle or entry.title or "") .. " (" .. self:getName(self.professionIndex) .. ")",
    NORMAL_FONT_COLOR)

  GameTooltip_AddBlankLineToTooltip(GameTooltip)

  if entry.description ~= nil then
    GameTooltip_AddHighlightLine(
      GameTooltip,
      entry.description
    )
    GameTooltip_AddBlankLineToTooltip(GameTooltip)
  end

  local completed = 0

  for index, itemId in ipairs(entry.items) do
    if not C_QuestLog.IsQuestFlaggedCompleted(entry.quests[index]) then
      local item = Item:CreateFromItemID(itemId)

      item:ContinueOnItemLoad(function()
        local itemName = item:GetItemName();

        local textureSettings = {
          width = 20,
          height = 20,
          verticalOffset = 4,
        };
        local color = item:GetItemQualityColor();
        GameTooltip:AddLine(itemName, color.r, color.g, color.b, true)
        GameTooltip:AddTexture(item:GetItemIcon(), textureSettings)

        if entry.descriptions and entry.descriptions[index] ~= nil then
          GameTooltip:AddLine(entry.descriptions[index], 255, 255, 255)
        end
      end)
    else
      completed = completed + 1
    end
  end

  if completed == #entry.quests then
    GameTooltip_AddHighlightLine(GameTooltip, "All items found this week")
  end

  GameTooltip:Show()
end
