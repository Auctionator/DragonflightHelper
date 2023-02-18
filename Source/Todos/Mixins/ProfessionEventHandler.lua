DFH_ProfessionEventHandler = {}

function DFH_ProfessionEventHandler:OnShow()
  FrameUtil.RegisterFrameForEvents(self, {
    "ENCOUNTER_LOOT_RECEIVED",
    "QUEST_TURNED_IN",
    "CURRENCY_DISPLAY_UPDATE"
  })
end

function DFH_ProfessionEventHandler:OnHide()
  FrameUtil.UnregisterFrameForEvents(self, {
    "ENCOUNTER_LOOT_RECEIVED",
    "QUEST_TURNED_IN",
    "CURRENCY_DISPLAY_UPDATE"
  })
end

function DFH_ProfessionEventHandler:OnEvent(event, ...)
  print("DFH_ProfessionEventHandler:OnEvent()", event, ...)

  if self.Update == nil then
    print("DFH_ProfessionEventHandler: No Update method found for this entry")
    return
  end

  if event == "ENCOUNTER_LOOT_RECEIVED" or event == "QUEST_TURNED_IN" or event == "CURRENCY_DISPLAY_UPDATE" then
    self:Update()
  end
end
