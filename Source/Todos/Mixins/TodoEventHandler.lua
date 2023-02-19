DFH_TodoEventHandler = {}

function DFH_TodoEventHandler:OnShow()
  FrameUtil.RegisterFrameForEvents(self, {
    "ENCOUNTER_LOOT_RECEIVED",
    "QUEST_TURNED_IN",
    "CURRENCY_DISPLAY_UPDATE"
  })
end

function DFH_TodoEventHandler:OnHide()
  FrameUtil.UnregisterFrameForEvents(self, {
    "ENCOUNTER_LOOT_RECEIVED",
    "QUEST_TURNED_IN",
    "CURRENCY_DISPLAY_UPDATE"
  })
end

function DFH_TodoEventHandler:OnEvent(event, ...)
  if self.Update == nil then
    print("DFH_TodoEventHandler: No Update method found for this entry")
    return
  end

  if event == "ENCOUNTER_LOOT_RECEIVED" or event == "QUEST_TURNED_IN" or event == "CURRENCY_DISPLAY_UPDATE" then
    self:Update()
  end
end
