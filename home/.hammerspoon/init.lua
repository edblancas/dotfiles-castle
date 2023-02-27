hs.hotkey.bind({"command"}, "f12", function()
  local alacritty = hs.application.get('Alacritty')
  if (alacritty ~= nil and alacritty:isFrontmost()) then
    alacritty:hide()
  else
    hs.application.launchOrFocus("/Applications/Alacritty.app")
    local alacritty = hs.application.find('alacritty')
    alacritty.setFrontmost(alacritty)
    alacritty.activate(alacritty)
  end
end)
