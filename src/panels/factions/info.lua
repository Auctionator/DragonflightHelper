local addon, ns = ...

local helpers = ns.components.helpers
local event_manager = ns.events.manager
local custom_events = ns.events.custom

local info = {}
local REPUTATION_EVENTS = {
  "UPDATE_FACTION",
  "MAJOR_FACTION_RENOWN_LEVEL_CHANGED",
  "MAJOR_FACTION_UNLOCKED",
  custom_events.THEME_LOADED
}

function info:attach(container, id)
  local listener_name = addon .. "_faction_listener_" .. helpers:get_id()
  local listener = CreateFrame("Frame", listener_name, container)

  local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed,
  hasRep, isWatched, isChild, factionID, hasBonusRepGain, canSetInactive = GetFactionInfoByID(id)

  local friend_data = factionID and C_GossipInfo.GetFriendshipReputation(factionID) or {}

  listener.data = {
    name = name,
    factionID = factionID,
    friend_data = friend_data,
    friend_id = friend_data.friendshipFactionID,
    is_major_faction = factionID and C_Reputation.IsMajorFaction(factionID),
    is_friend_faction = friend_data and friend_data.friendshipFactionID > 0
  }

  if listener.data.is_friend_faction then
    function container:update_data()
      listener.data.detail = friend_data.reaction
      listener.data.color = FACTION_BAR_COLORS[standingID]

      if friend_data.nextThreshold then
        listener.data.bar_min = friend_data.reactionThreshold
        listener.data.bar_max = friend_data.nextThreshold
        listener.data.bar_value = friend_data.standing
      else
        listener.data.bar_min = 0
        listener.data.bar_max = 1
        listener.data.bar_value = 1
      end
    end

    function container:show_tooltip()
      GameTooltip:SetOwner(container, "ANCHOR_RIGHT");

      local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(friend_data.friendshipFactionID)

      if (rankInfo.maxLevel > 0) then
        GameTooltip:SetText(
          friend_data.name .. " (" .. rankInfo.currentLevel .. " / " ..
          rankInfo.maxLevel .. ")", 1, 1, 1
        )
      else
        GameTooltip:SetText(friend_data.name, 1, 1, 1)
      end

      GameTooltip:AddLine(friend_data.text, nil, nil, nil, true)

      if (friend_data.nextThreshold) then
        local current = friend_data.standing -
            friend_data.reactionThreshold
        local max = friend_data.nextThreshold -
            friend_data.reactionThreshold

        GameTooltip:AddLine(
          friend_data.reaction .. " (" .. current .. " / " ..
          max .. ")", 1, 1, 1, true
        )
      else
        GameTooltip:AddLine(friend_data.reaction, 1, 1, 1, true)
      end
      GameTooltip:Show();
    end
  elseif listener.data.is_major_faction then
    function container:update_data()
      listener.data.faction_data = C_MajorFactions.GetMajorFactionData(factionID)
      listener.data.bar_min = 0
      listener.data.bar_max = listener.data.faction_data.renownLevelThreshold
      listener.data.color = BLUE_FONT_COLOR

      listener.data.bar_value = C_MajorFactions.HasMaximumRenown(factionID) and
          listener.data.faction_data.renownLevelThreshold or
          listener.data.faction_data.renownReputationEarned or 0
      listener.data.detail = RENOWN_LEVEL_LABEL .. listener.data.faction_data.renownLevel
    end

    function container:show_tooltip()
      local function AddRenownRewardsToTooltip(renownRewards)
        GameTooltip_AddHighlightLine(GameTooltip, MAJOR_FACTION_BUTTON_TOOLTIP_NEXT_REWARDS);

        for _, rewardInfo in ipairs(renownRewards) do
          local renownRewardString
          local icon, name = RenownRewardUtil.GetRenownRewardInfo(
            rewardInfo,
            GenerateClosure(self.show_tooltip, self)
          )

          if icon then
            local file, width, height = icon, 16, 16
            local rewardTexture = CreateSimpleTextureMarkup(file, width, height)
            renownRewardString = rewardTexture .. " " .. name;
          end
          local wrapText = false;
          GameTooltip_AddNormalLine(GameTooltip, renownRewardString, wrapText)
        end
      end

      GameTooltip:SetOwner(container, "ANCHOR_RIGHT");

      local faction_info = C_MajorFactions.GetMajorFactionData(factionID)

      GameTooltip_SetTitle(GameTooltip, faction_info.name, NORMAL_FONT_COLOR)
      GameTooltip_AddColoredLine(
        GameTooltip,
        RENOWN_LEVEL_LABEL .. faction_info.renownLevel,
        BLUE_FONT_COLOR
      )
      GameTooltip_AddBlankLineToTooltip(GameTooltip);

      GameTooltip_AddHighlightLine(
        GameTooltip,
        MAJOR_FACTION_RENOWN_TOOLTIP_PROGRESS:format(faction_info.name)
      )
      GameTooltip_AddBlankLineToTooltip(GameTooltip)

      local nextRenownRewards = C_MajorFactions.GetRenownRewardsForLevel(
        faction_info.factionID,
        C_MajorFactions.GetCurrentRenownLevel(faction_info.factionID) + 1
      )
      if #nextRenownRewards > 0 then
        AddRenownRewardsToTooltip(nextRenownRewards);
      end

      GameTooltip:Show();
    end
  end

  function listener:notify()
    container:update_data()
    local data = listener.data

    container.title:SetText(name)
    container.description:SetText(data.detail)
    container.foreground:SetStatusBarColor(data.color.r, data.color.g, data.color.b, data.color.a)
    container.foreground:SetMinMaxValues(data.bar_min, data.bar_max)
    container.background:SetMinMaxValues(data.bar_min, data.bar_max)
    container.foreground:SetValue(data.bar_value)
  end

  container.button:SetScript("OnEnter", function()
    container.description:SetText(("%d / %d"):format(listener.data.bar_value, listener.data.bar_max))
    container:show_tooltip()
  end)
  container.button:SetScript("OnLeave", function()
    container.description:SetText(listener.data.detail)
    GameTooltip:Hide()
  end)

  event_manager:subscribe(listener, REPUTATION_EVENTS, listener_name)
  listener:notify()
end

ns.factions.info = info
