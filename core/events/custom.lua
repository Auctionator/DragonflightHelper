local _, ns = ...

ns.events.custom = {
  ["MAIN_FRAME_REPOSITIONED"] = "MAIN_FRAME_REPOSITIONED",
  ["MAIN_FRAME_LOADED"] = "MAIN_FRAME_LOADED",
  ["MAIN_FRAME_SHOWN"] = "MAIN_FRAME_SHOWN",
  ["OPEN_CONFIG"] = "OPEN_CONFIG",
  ["CLOSE_CONFIG"] = "CLOSE_CONFIG",
  ["FONT_CHANGED"] = "FONT_CHANGED",
  ["STATUSBAR_TEXTURE_CHANGED"] = "STATUSBAR_TEXTURE_CHANGED",
  ["MEDIA_LOADED"] = "MEDIA_LOADED",
  ["THEME_LOADED"] = "THEME_LOADED",
  ["THEME_MEDIA_UPDATED"] = "THEME_MEDIA_UPDATED",
  ["THEME_SECTIONS_UPDATED"] = "THEME_SECTIONS_UPDATED",
  ["NEW_FONT_AVAILABLE"] = "NEW_FONT_AVAILABLE",
  ["NEW_STATUSBAR_AVAILABLE"] = "NEW_STATUSBAR_AVAILABLE",
  ["SECTION_SELECTION_CHANGED"] = "SECTION_SELECTION_CHANGED",
  ["SUBSECTION_SELECTION_CHANGED"] = "SUBSECTION_SELECTION_CHANGED",
  ["BACKGROUND_OPACITY_CHANGED"] = "BACKGROUND_OPACITY_CHANGED",
  ["FRAME_SHOWING_CHANGED"] = "FRAME_SHOWING_CHANGED",
  ["FRAME_LOCKED_CHANGED"] = "FRAME_LOCKED_CHANGED",
  -- Profession events
  ["PROFESSIONS_LOADED"] = "PROFESSIONS_LOADED",
  ["PROFESSION_LOADED"] = "PROFESSION_LOADED",
  ["CHECK_FOR_COMPLETED_TREATISE"] = "CHECK_FOR_COMPLETED_TREATISE"
}
