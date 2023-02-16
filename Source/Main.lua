DragonflightHelperReputationMixin = {}

function DragonflightHelperReputationMixin:OnLoad()
    print(self.factionId)
end

DragonflightHelperMixin_2 = {};

function DragonflightHelperMixin_2:OnLoad()
    self:RegisterForDrag("RightButton");
end

function DragonflightHelperMixin_2:OnShow()
end

function DragonflightHelperMixin_2:OnDragStart()
    self:StartMoving();
end

function DragonflightHelperMixin_2:OnDragStop()
    self:StopMovingOrSizing();
end

DragonflightHelperMixin = {};
function DragonflightHelperMixin:OnLoad()
    self:RegisterForDrag("RightButton");

    local view = CreateScrollBoxListLinearView();

    view:SetElementInitializer("DFH_ReputationBarTemplate", function(button, elementData)
        self:InitEntry(button, elementData);
    end);
    view:SetPadding(0, 0, 0, 2, 2);

    ScrollUtil.InitScrollBoxListWithScrollBar(self.ScrollBox, self.ScrollBar, view);
end

function DragonflightHelperMixin:OnShow()
    self:Update();
end

function DragonflightHelperMixin:Update()
    local newDataProvider = CreateDataProvider();

    for i = 3, 12 do
        newDataProvider:Insert({ index = i });
    end
    DragonflightHelperFrame.ScrollBox:SetDataProvider(newDataProvider, ScrollBoxConstants.RetainScrollPosition);
end

function DragonflightHelperMixin:OnDragStart()
    self:StartMoving();
end

function DragonflightHelperMixin:OnDragStop()
    self:StopMovingOrSizing();
end

function DragonflightHelperMixin:InitEntry(factionRow, elementData)
    local factionIndex = elementData.index;
    local factionContainer = factionRow.Container;
    local factionBar = factionContainer.ReputationBar;
    local factionTitle = factionContainer.Name;
    local factionStanding = factionBar.FactionStanding;

    local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed,
    hasRep, isWatched, isChild, factionID, hasBonusRepGain, canSetInactive = GetFactionInfo(factionIndex);
    factionTitle:SetText(name);

    factionRow.index = factionIndex;
    factionRow.factionID = factionID;
    factionRow.isCollapsed = isCollapsed;

    local colorIndex = standingID;
    local barColor = FACTION_BAR_COLORS[colorIndex];
    local factionStandingtext;

    local isParagon = factionID and C_Reputation.IsFactionParagon(factionID);
    if (isParagon) then
        local paragonFrame = factionContainer.Paragon;
        paragonFrame.factionID = factionID;
        local currentValue, threshold, rewardQuestID, hasRewardPending,
        tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(
                factionID);
        C_Reputation.RequestFactionParagonPreloadRewardData(factionID);
        paragonFrame.Glow:SetShown(not tooLowLevelForParagon and
        hasRewardPending);
        paragonFrame.Check:SetShown(not tooLowLevelForParagon and
        hasRewardPending);
    end
    factionContainer.Paragon:SetShown(isParagon);

    local isCapped;
    if (standingID == MAX_REPUTATION_REACTION) then
        isCapped = true;
    end
    -- check if this is a friendship faction or a Major Faction
    local isMajorFaction = factionID and C_Reputation.IsMajorFaction(factionID);
    local repInfo = factionID and
        C_GossipInfo.GetFriendshipReputation(factionID);
    if (repInfo and repInfo.friendshipFactionID > 0) then
        factionStandingtext = repInfo.reaction;
        if (repInfo.nextThreshold) then
            barMin, barMax, barValue = repInfo.reactionThreshold,
                repInfo.nextThreshold, repInfo.standing;
        else
            -- max rank, make it look like a full bar
            barMin, barMax, barValue = 0, 1, 1;
            isCapped = true;
        end
        local friendshipColorIndex = 5;
        barColor = FACTION_BAR_COLORS[colorIndex]; -- always color friendships green
        factionRow.friendshipID = repInfo.friendshipFactionID; -- for doing friendship tooltip
    elseif (isMajorFaction) then
        local majorFactionData = C_MajorFactions.GetMajorFactionData(factionID);

        barMin, barMax = 0, majorFactionData.renownLevelThreshold;
        isCapped = C_MajorFactions.HasMaximumRenown(factionID);
        barValue = isCapped and majorFactionData.renownLevelThreshold or
            majorFactionData.renownReputationEarned or 0;
        barColor = BLUE_FONT_COLOR;

        factionRow.friendshipID = nil;
        factionStandingtext = RENOWN_LEVEL_LABEL .. majorFactionData.renownLevel;
    else
        local gender = UnitSex("player");
        factionStandingtext = GetText("FACTION_STANDING_LABEL" .. standingID,
                gender);
        factionRow.friendshipID = nil;
    end

    factionStanding:SetText(factionStandingtext);

    -- Normalize Values
    barMax = barMax - barMin;
    barValue = barValue - barMin;
    barMin = 0;

    factionRow.standingText = factionStandingtext;
    if (isCapped) then
        factionRow.rolloverText = nil;
    else
        factionRow.rolloverText = HIGHLIGHT_FONT_COLOR_CODE .. " " ..
            format(REPUTATION_PROGRESS_FORMAT,
                BreakUpLargeNumbers(barValue),
                BreakUpLargeNumbers(barMax)) ..
            FONT_COLOR_CODE_CLOSE;
    end
    factionBar:SetFillStyle("STANDARD_NO_RANGE_FILL");
    factionBar:SetMinMaxValues(0, barMax);
    factionBar:SetValue(barValue);
    factionBar:SetStatusBarColor(barColor.r, barColor.g, barColor.b);

    factionBar.BonusIcon:SetShown(hasBonusRepGain);

    self:SetRowType(factionRow, isChild, isHeader, hasRep);

    factionRow:Show();
end

function DragonflightHelperMixin:SetRowType(factionRow, isChild, isHeader, hasRep) -- rowType is a binary table of type isHeader, isChild
    local factionContainer = factionRow.Container;
    local factionBar = factionContainer.ReputationBar;
    local factionTitle = factionContainer.Name;
    local factionButton = factionContainer.ExpandOrCollapseButton;
    local factionBackground = factionContainer.Background;
    local factionStanding = factionBar.FactionStanding;
    local factionLeftTexture = factionBar.LeftTexture;
    local factionRightTexture = factionBar.RightTexture;

    factionLeftTexture:SetWidth(62);
    factionRightTexture:SetWidth(42);
    factionBar:SetPoint("RIGHT", 0, 0);
    if (isHeader) then
        local isMajorFactionHeader = factionRow.factionID and
            C_Reputation.IsMajorFaction(
                factionRow.factionID);

        local xOffset = isMajorFactionHeader and 25 or isChild and 21 or 2;
        local yOffset = 0;
        factionContainer:SetPoint("LEFT", xOffset, yOffset);

        factionButton:SetPoint("LEFT", factionContainer, "LEFT", 3, 0);
        factionButton:Show();

        factionTitle:SetPoint("LEFT", factionButton, "RIGHT", 0, 0);
        local relativePoint = hasRep and "LEFT" or "RIGHT";
        factionTitle:SetPoint("RIGHT", factionBar, relativePoint, -3, 0);
        factionTitle:SetFontObject(isMajorFactionHeader and
        GameFontHighlightSmall or
        GameFontNormalLeft);

        factionBackground:SetShown(isMajorFactionHeader);

        if isMajorFactionHeader then
            factionLeftTexture:SetHeight(21);
            factionRightTexture:SetHeight(21);
            factionLeftTexture:SetTexCoord(0.7578125, 1.0, 0.0, 0.328125);
            factionRightTexture:SetTexCoord(0.0, 0.1640625, 0.34375, 0.671875);
            factionBar:SetWidth(101);
        else
            factionLeftTexture:SetHeight(15);
            factionLeftTexture:SetWidth(60);
            factionRightTexture:SetHeight(15);
            factionRightTexture:SetWidth(39);
            factionLeftTexture:SetTexCoord(0.765625, 1.0, 0.046875, 0.28125);
            factionRightTexture:SetTexCoord(0.0, 0.15234375, 0.390625, 0.625);
            factionBar:SetWidth(99);
        end
    else
        local xOffset = isChild and 44 or 25;
        local yOffset = 0;
        factionContainer:SetPoint("LEFT", xOffset, yOffset);

        factionButton:Hide();
        factionTitle:SetPoint("LEFT", 10, 0);
        factionTitle:SetPoint("RIGHT", factionBar, "LEFT", -3, 0);
        factionTitle:SetFontObject(GameFontHighlightSmall);
        factionBackground:Show();
        factionLeftTexture:SetHeight(21);
        factionRightTexture:SetHeight(21);
        factionLeftTexture:SetTexCoord(0.7578125, 1.0, 0.0, 0.328125);
        factionRightTexture:SetTexCoord(0.0, 0.1640625, 0.34375, 0.671875);
        factionBar:SetWidth(101)
    end

    factionStanding:SetShown(hasRep or not isHeader);
    factionBar:SetShown(hasRep or not isHeader);
    factionBar:GetParent():GetParent().hasRep = hasRep or not isHeader;
end
