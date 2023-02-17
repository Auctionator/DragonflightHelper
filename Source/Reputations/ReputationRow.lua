DragonflightHelperReputationRowMixin = {}

function DragonflightHelperReputationRowMixin:OnLoad()
  -- print("DragonflightHelperReputationRowMixin:OnLoad()")
end

function DragonflightHelperReputationRowMixin:Init(factionSettings)
  self.factionInfo = DragonflightHelper.FactionInfo:new()
  self.factionInfo:init(factionSettings.factionIndex)

  self:SetTitle(self.factionInfo.title)
  self:SetDescription(self.factionInfo.detail)

  if self.factionInfo:isMajorFaction() then
    self:SetRolloverDescription(("%d / %d"):format(self.factionInfo.barValue, self.factionInfo.barMax))
  end

  self:SetMinMaxValues(self.factionInfo.barMin, self.factionInfo.barMax)
  self:SetValue(self.factionInfo.barValue)
  self:SetForegroundColor(factionSettings.color.r, factionSettings.color.g, factionSettings.color.b, 1)

  self.enterCallback = function()
    if self.factionInfo:isFriendFaction() then
      self:ShowFriendshipReputationTooltip()
    else
      self:ShowMajorFactionRenownTooltip()
    end
  end

  self.leaveCallback = function()
    GameTooltip:Hide()
  end
end

-- Copied from ReputationFrame.xml and ReputationFrame.lua (Mixing in was a problem because data)
function DragonflightHelperReputationRowMixin:ShowFriendshipReputationTooltip()
  if (
      self.factionInfo.friendshipFactionData and
      self.factionInfo.friendshipFactionData.friendshipFactionID and
      self.factionInfo.friendshipFactionData.friendshipFactionID > 0) then
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");

    local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(
      self.factionInfo.friendshipFactionData.friendshipFactionID
    )
    if (rankInfo.maxLevel > 0) then
      GameTooltip:SetText(
        self.factionInfo.friendshipFactionData.name .. " (" .. rankInfo.currentLevel .. " / " ..
        rankInfo.maxLevel .. ")", 1, 1, 1
      )
    else
      GameTooltip:SetText(self.factionInfo.friendshipFactionData.name, 1, 1, 1)
    end

    GameTooltip:AddLine(self.factionInfo.friendshipFactionData.text, nil, nil, nil, true)

    if (self.factionInfo.friendshipFactionData.nextThreshold) then
      local current = self.factionInfo.friendshipFactionData.standing -
          self.factionInfo.friendshipFactionData.reactionThreshold
      local max = self.factionInfo.friendshipFactionData.nextThreshold -
          self.factionInfo.friendshipFactionData.reactionThreshold

      GameTooltip:AddLine(
        self.factionInfo.friendshipFactionData.reaction .. " (" .. current .. " / " ..
        max .. ")", 1, 1, 1, true
      )
    else
      GameTooltip:AddLine(self.factionInfo.friendshipFactionData.reaction, 1, 1, 1, true)
    end
    GameTooltip:Show();
  end
end

function DragonflightHelperReputationRowMixin:ShowMajorFactionRenownTooltip()
  local function AddRenownRewardsToTooltip(renownRewards)
    GameTooltip_AddHighlightLine(GameTooltip, MAJOR_FACTION_BUTTON_TOOLTIP_NEXT_REWARDS);

    for _, rewardInfo in ipairs(renownRewards) do
      local renownRewardString
      local icon, name, _description =
          RenownRewardUtil.GetRenownRewardInfo(
            rewardInfo,
            GenerateClosure(self.ShowMajorFactionRenownTooltip, self)
          )

      if icon then
        local file, width, height = icon, 16, 16;
        local rewardTexture = CreateSimpleTextureMarkup(file, width,
          height);
        renownRewardString = rewardTexture .. " " .. name;
      end
      local wrapText = false;
      GameTooltip_AddNormalLine(GameTooltip, renownRewardString, wrapText);
    end
  end

  GameTooltip:SetOwner(self, "ANCHOR_RIGHT");

  local tooltipTitle = self.factionInfo.name;
  GameTooltip_SetTitle(GameTooltip, tooltipTitle, NORMAL_FONT_COLOR)
  GameTooltip_AddColoredLine(
    GameTooltip,
    RENOWN_LEVEL_LABEL .. self.factionInfo.majorFactionData.renownLevel,
    BLUE_FONT_COLOR
  )
  GameTooltip_AddBlankLineToTooltip(GameTooltip);

  GameTooltip_AddHighlightLine(
    GameTooltip,
    MAJOR_FACTION_RENOWN_TOOLTIP_PROGRESS:format(self.factionInfo.name)
  )
  GameTooltip_AddBlankLineToTooltip(GameTooltip)

  local nextRenownRewards = C_MajorFactions.GetRenownRewardsForLevel(
    self.factionInfo.factionId,
    C_MajorFactions.GetCurrentRenownLevel(self.factionInfo.factionId) + 1
  )
  if #nextRenownRewards > 0 then
    AddRenownRewardsToTooltip(nextRenownRewards);
  end

  GameTooltip:Show();
end
