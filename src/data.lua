local constants = require("constants")

local function mipped_icon(name, position, filename, size, mipmap_count, mods)
  local def = {
    type = "sprite",
    name = name,
    filename = filename,
    position = position,
    size = size or 32,
    mipmap_count = mipmap_count or 2,
    flags = {"icon"}
  }
  if mods then
    for k,v in pairs(mods) do
      def[k] = v
    end
  end
  return def
end

local shortcut_sheet = "__RateCalculator__/graphics/shortcut.png"

data:extend{
  -- custom input
  {
    type = "custom-input",
    name = "rcalc-get-selection-tool",
    key_sequence = "ALT + X",
    action = "create-blueprint-item",
    item_to_create = "rcalc-selection-tool"
  },
  -- selection tool
  {
    type = "selection-tool",
    name = "rcalc-selection-tool",
    icons = {
      {icon="__RateCalculator__/graphics/black.png", icon_size=1, scale=64},
      {icon="__RateCalculator__/graphics/selection-tool.png", icon_size=32, mipmap_count=2}
    },
    selection_mode = "any-entity",
    selection_color = {r=1,g=1,b=0},
    selection_cursor_box_type = "entity",
    entity_type_filters = constants.crafter_types,
    alt_selection_mode = "nothing",
    alt_selection_color = {r=1,g=0,b=0},
    alt_selection_cursor_box_type = "not-allowed",
    stack_size = 1,
    flags = {"hidden", "only-in-cursor", "not-stackable"}
  },
  -- shortcut
  {
    type = "shortcut",
    name = "rcalc-get-selection-tool",
    icon = mipped_icon(nil, {0,0}, shortcut_sheet, 32, 2),
    disabled_icon = mipped_icon(nil, {48,0}, shortcut_sheet, 32, 2),
    small_icon = mipped_icon(nil, {0,32}, shortcut_sheet, 24, 2),
    disabled_small_icon = mipped_icon(nil, {36,32}, shortcut_sheet, 24, 2),
    action = "create-blueprint-item",
    item_to_create = "rcalc-selection-tool",
    associated_control_input = "rcalc-get-selection-tool"
  }
}

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!! DEBUGGING - REMEMBER TO REMOVE !!!!!!!!!!!!!!!!!

local results = data.raw.recipe["uranium-processing"].results
results[1].amount = nil
results[1].amount_min = 1
results[1].amount_max = 5
-- results[1].probability = 1

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- -----------------------------------------------------------------------------
-- GUI STYLES

local styles = data.raw["gui-style"].default

-- CHECKBOX STYLES

local empty_checkmark = {
  filename = "__core__/graphics/empty.png",
  priority = "very-low",
  width = 1,
  height = 1,
  frame_count = 1,
  scale = 8
}

-- inactive is grey until hovered
-- checked = descending, unchecked = ascending
styles.rcalc_sort_checkbox_inactive = {
  type = "checkbox_style",
  font = "default-bold",
  -- font_color = bold_font_color,
  padding = 0,
  default_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-white.png",
    size = {16, 16},
    scale = 0.5
  },
  hovered_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-hover.png",
    size = {16, 16},
    scale = 0.5
  },
  clicked_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-white.png",
    size = {16, 16},
    scale = 0.5
  },
  disabled_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-white.png",
    size = {16, 16},
    scale = 0.5
  },
  selected_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-white.png",
    size = {16, 16},
    scale = 0.5
  },
  selected_hovered_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-hover.png",
    size = {16, 16},
    scale = 0.5
  },
  selected_clicked_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-white.png",
    size = {16, 16},
    scale = 0.5
  },
  selected_disabled_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-white.png",
    size = {16, 16},
    scale = 0.5
  },
  checkmark = empty_checkmark,
  disabled_checkmark = empty_checkmark,
  text_padding = 5
}

-- active is orange by default
styles.rcalc_sort_checkbox_active = {
  type = "checkbox_style",
  parent = "rcalc_sort_checkbox_inactive",
  -- font_color = bold_font_color,
  default_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-active.png",
    size = {16, 16},
    scale = 0.5
  },
  selected_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-active.png",
    size = {16, 16},
    scale = 0.5
  }
}

-- FRAME STYLES

styles.rcalc_material_list_box_frame = {
  type = "frame_style",
  parent = "inside_deep_frame",
  height = 300,
  graphical_set = {
    base = {
      position = {85,0},
      corner_size = 8,
      draw_type = "outer",
      center = {position={42,8}, size=1}
    },
    shadow = default_inner_shadow
  }
}

styles.rcalc_material_info_frame = {
  type = "frame_style",
  parent = "statistics_table_item_frame",
  top_padding = 2,
  bottom_padding = 2
}

-- SCROLL PANE STYLES

styles.rcalc_material_list_box_scroll_pane = {
  type = "scroll_pane_style",
  extra_padding_when_activated = 0,
  padding = 0,
  vertically_stretchable = "on",
  graphical_set = {
    shadow = default_inner_shadow
  },
  background_graphical_set = {
    position = {282, 17},
    corner_size = 8,
    -- overall_tiling_horizontal_size = 194,
    overall_tiling_vertical_size = 32,
    overall_tiling_horizontal_padding = 8,
    overall_tiling_vertical_padding = 8,
    overall_tiling_vertical_spacing = 12,
  },
  vertical_flow_style = {
    type = "vertical_flow_style",
    vertical_spacing = 0
  }
}

-- styles.rcalc_ingredients_list_box_scroll_pane = {
--   type = "scroll_pane_style",
--   parent = "rcalc_material_list_box_scroll_pane",
--   width = 210
-- }

-- styles.rcalc_products_list_box_scroll_pane = {
--   type = "scroll_pane_style",
--   parent = "rcalc_material_list_box_scroll_pane",
--   width = 393
-- }