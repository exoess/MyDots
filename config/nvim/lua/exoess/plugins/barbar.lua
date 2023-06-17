vim.g.barbar_auto_setup = false -- disable auto-setup

require'barbar'.setup {
  icons = {
    buffer_index = false,
    buffer_number = false,
    button = '',

    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
      [vim.diagnostic.severity.WARN] = {enabled = false},
      [vim.diagnostic.severity.INFO] = {enabled = false},
      [vim.diagnostic.severity.HINT] = {enabled = true},
    },
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '~'},
      deleted = {enabled = true, icon = '-'},
    },
    filetype = {

      custom_colors = false,

      enabled = true,
    },
    separator = {left = '\u{E0BC}', right = '\u{E0BE}'},

    separator_at_end = true,

    modified = {button = '●'},
    pinned = {button = '', filename = true},

    preset = 'slanted',

    alternate = {filetype = {enabled = false}},
    current = {buffer_index = true},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
  },

  maximum_padding = 1,

  minimum_padding = 1,

  maximum_length = 30,

  minimum_length = 0,
}
