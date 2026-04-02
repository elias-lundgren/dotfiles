return {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    file_ignore_patterns = {
      "%.git/",
      "node_modules/",
      "%.DS_Store",
      "lazy%-lock%.json",
    },
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
    },
    live_grep = {
      additional_args = { "--hidden", "--no-ignore" },
    },
  },
  extensions = {
    project = {
      base_dirs = { 
        {
          path = "~/code",
          max_depth = 10,
        } 
      },
      hidden_files = true,
      theme = "dropdown",
      order_by = "asc",
      search_by = "path",
      sync_with_nvim_tree = true,
    },
  },
}
