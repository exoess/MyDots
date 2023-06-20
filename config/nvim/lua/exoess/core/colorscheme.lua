local status, _ = pcall(vim.cmd, "colorscheme omni")
if not status then
  print("Colorscheme not found!")
  return
end
