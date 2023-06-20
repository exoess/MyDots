vim.g.barbar_auto_setup = false -- disable auto-setup

require'barbar'.setup {
  auto_hide = true,
  icons = {
    separator = {left = '\u{258E}', right = '\u{0020}'},
    preset = 'default',
  },
}
