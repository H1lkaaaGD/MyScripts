local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

if character then
    character:SetAttribute("CanJump", true)
    print("Братан, " .. player.Name .. " теперь может прыгать как честный пацан!")
else
    print("Чёрта не загрузило, кореш... Может, его в бане?")
end
