DFH_ProfessionUpdate = CreateFromMixins(DFH_GenericUpdate)

local ProfessionQuests = {
  Treatise = {
    title = "Draconic Treatise",
    [171] = { quests = { 74108 } }, -- Alchemy
    [164] = { quests = { 74109 } }, -- Blacksmithing
    [333] = { quests = { 74110 } }, -- Enchanting
    [202] = { quests = { 74111 } }, -- Engineering
    [182] = { quests = { 74107 } }, -- Herbalism
    [773] = { quests = { 74105 } }, -- Inscription
    [755] = { quests = { 74112 } }, -- Jewelcrafting
    [165] = { quests = { 74113 } }, -- Leatherworking
    [186] = { quests = { 74106 } }, -- Mining
    [393] = { quests = { 74114 } }, -- Skinning
    [197] = { quests = { 74115 } }, -- Tailoring
  },
  Gathering = {
    [182] = { title = "Dreambloom", quests = { 71857, 71858, 71859, 71860, 71861, 71864 } }, -- Herbalism
    [186] = { title = "Iridescent Ore", quests = { 72160, 72161, 72162, 72163, 72164, 72165 } }, -- Mining
    [393] = { title = "Curious Hide", quests = { 70381, 70383, 70384, 70385, 70386, 70389 } }, -- Skinning
    [171] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66373, 66374 } }, -- Alchemy
    [164] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66381, 66382 } }, -- Blacksmithing
    [333] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66377, 66378 } }, -- Enchanting
    [202] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66379, 66380 } }, -- Engineering
    [773] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66375, 66376 } }, -- Inscription
    [755] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66388, 66389 } }, -- Jewelcrafting
    [165] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66384, 66385 } }, -- Leatherworking
    [197] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66386, 66387 } }, -- Tailoring
  },
  ValdrakkenRabul = {
    -- Like treatises; figure out quest ID
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
    [165] = { quests = { 70594 } }, -- Leatherworking
    [197] = { quests = { 70595 } }, -- Tailoring
    [755] = { quests = { 70593 } }, -- Jewelcrafting
    [164] = { quests = { 70589 } }, -- Blacksmithing
    [202] = { quests = { 70591 } }, -- Engineering
    [773] = { quests = { 70592 } }, -- Inscription
  },
  ValdrakkenTrainers = {
    [171] = { title = "Conflago <Trainer>", quests = { 70532, 70533, 70530, 70531 }, completionCount = 1 },
    [164] = { title = "Metalshaper Kuroko <Trainer>", quests = { 70234, 70233, 70235, 70211 }, completionCount = 1 },
    [333] = { title = "Soragosa <Trainer>", quests = { 72175, 72173, 72172, 72155 }, completionCount = 1 },
    [202] = { title = "Clinkyclick Shatterboom <Trainer>", quests = { 70540, 70539, 70545, 70557 }, completionCount = 1 },
    [182] = { title = "Agrikus <Trainer>", quests = { 70614, 70613, 70616 }, completionCount = 1 },
    [773] = { title = "Talendara <Trainer>", quests = { 70561, 70558, 70559, 70560 }, completionCount = 1 },
    [755] = { title = "Tuluradormi <Trainer>", quests = { 70565, 70564, 70563, 70562 }, completionCount = 1 },
    [165] = { title = "Hideshaper Koruz <Trainer>", quests = { 70571, 70569, 70568, 70567 }, completionCount = 1 },
    [186] = { title = "Sekita the Burrower <Trainer>", quests = { 72156, 70617, 70618, 72157 }, completionCount = 1 },
    [393] = { title = "Ralathor the Rugged <Trainer>", quests = { 72158, 70619, 72159, 70620 }, completionCount = 1 },
    [197] = { title = "Threadfinder Fulafong <Trainer>", quests = { 70587, 70586, 70572, 70582 }, completionCount = 1 },
  },
  Valdrakken = {
    title = "Valdrakken Weekly Profession",
    -- Alchemy
    [171] = { completionCount = 1, quests = {
      -- Dhurrel <Trade Liaison>
      72427, 66940, 66938,
      -- Dothenos <Trade Coordinator>
      66937
    } },
    -- Leatherworking
    [165] = { completionCount = 1, quests = {
      -- Dhurrel <Trade Liaison>
      66363,
      -- Temnaayu <Trade Negotiator>
      66951, 72407, 66364
    } },
    -- Blacksmithing
    [164] = { completionCount = 1, quests = {
      -- Dhurrel <Trade Liaison>
      66517, 66897, 66941
    } },
    -- Jewelcrafting
    [755] = { completionCount = 1, quests = {
      -- Temnaayu <Trade Negotiator>
      66950, 66949,
      -- Gnoklin Quirkcoil <Requisitions Officer>
      72428, 66516
    } },
    -- Enchanting
    [333] = { completionCount = 1, quests = {
      -- Temnaayu <Trade Negotiator>
      66900, 66884, 72423,
      -- Gnoklin Quirkcoil <Requisitions Officer>
      66935
    } },
    -- Tailoring
    [197] = { completionCount = 1, quests = {
      -- Dothenos <Trade Coordinator>
      66952,
      -- Gnoklin Quirkcoil <Requisitions Officer>
      72410
    } },
    -- Engineering
    [202] = { completionCount = 1, quests = {
      -- Dothenos <Trade Coordinator>
      72396, 66890,
      -- Gnoklin Quirkcoil <Requisitions Officer>
      66942, 66891
    } },
    -- Inscription
    [773] = { completionCount = 1, quests = {
      -- Dothenos <Trade Coordinator>
      66945, 72438, 66943,
      -- Gnoklin Quirkcoil <Requisitions Officer>
      66944
    } },
  },
  WeeklyDrops = {
    title = "Weekly Mob Drops",
    [171] = { quests = { 70511, 70504 } }, -- Alchemy
    [165] = { quests = { 70523, 70522 } }, -- Leatherworking
    [197] = { quests = { 70524, 70525 } }, -- Tailoring
    [755] = { quests = { 70521, 70520 } }, -- Jewelcrafting
    [164] = { quests = { 70513, 70512 } }, -- Blacksmithing
    [202] = { quests = { 70516, 70517 } }, -- Engineering
    [773] = { quests = { 70518, 70519 } }, -- Inscription
    [333] = { quests = { 70514, 70515 } }, -- Enchanting
  }
}

function DFH_ProfessionUpdate:CollapseFrame()
  self:Hide()
  self:SetHeight(1)

  -- This should be "TOPLEFT"
  local point, relativeTo, relativePoint = self:GetPoint()
  self:SetPoint(point, relativeTo, relativePoint, 0, 1)
end

function DFH_ProfessionUpdate:Update()
  print("DFH_ProfessionUpdate:Update()")

  if self.professionIndex == nil then
    print("[INCORRECT USAGE] DFH_ProfessionUpdate: A professionIndex must be provided")
    self:SetTitle("Unknown profession")
    return
  end

  if not self:hasProfession(self.professionIndex) then
    self:SetTitle("No profession selected")
    return
  end

  if self.questTypeKey == nil then
    print("[INCORRECT USAGE] DFH_ProfessionUpdate: A questTypeKey object must be initialized")
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
  DFH_GenericUpdate.update(self, entry[self:getId(self.professionIndex)], entry.title)
end
