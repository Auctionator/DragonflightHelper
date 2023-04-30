local addon, ns = ...
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local log = ns.debug.log

local LSM = LibStub("LibSharedMedia-3.0")
local media = {}

function media:init()
  self.fonts = {}
  self.statusbars = {}

  event_manager:subscribe(self, {
    custom_events.NEW_STATUSBAR_AVAILABLE,
    custom_events.NEW_FONT_AVAILABLE
  }, "Media Loader")
end

function media:notify(event_name, ...)
  log(nil, "media_loader", 1, "notify", event_name, ...)

  if event_name == custom_events.NEW_FONT_AVAILABLE then
    local font_name = ...

    if self.fonts[font_name] == nil then
      self.fonts[font_name] = CreateFont(addon .. "_font_" .. font_name)
    end

    self.fonts[font_name]:SetFont(LSM:Fetch("font", font_name), 12, "")
  elseif event_name == custom_events.NEW_STATUSBAR_AVAILABLE then
    local statusbar_name, _ = ...

    self.statusbars[statusbar_name] = LSM:Fetch("statusbar", statusbar_name)
  end
end

function media:get_font_object(font)
  if font == nil then
    font = LSM:GetDefault("font")
  end

  if self.fonts[font] == nil then
    self.fonts[font] = CreateFont(addon .. "_font_" .. font)
    self.fonts[font]:SetFont(LSM:Fetch("font", font), 12, "")
  end

  return self.fonts[font] or self.fonts[self:get_default_font()]
end

function media:get_statusbar(statusbar)
  if self.statusbars[statusbar] == nil then
    self.statusbars[statusbar] = LSM:Fetch("statusbar", statusbar)
  end

  return self.statusbars[statusbar]
end

function media:get_default_font()
  return LSM:GetDefault("font")
end

function media:get_default_statusbar()
  return LSM:GetDefault("statusbar")
end

media:init()
ns.media = media
ns.media.shared = LSM
