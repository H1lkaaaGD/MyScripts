local Players = game:GetService("Players")

local function setupPlayerModel(player)
    if not player:GetAttribute("CanJump") then
        player:SetAttribute("CanJump", true)
        print("Атрибут CanJump создан для игрока", player.Name)
    end
end

Players.PlayerAdded:Connect(setupPlayerModel)

for _, player in ipairs(Players:GetPlayers()) do
    setupPlayerModel(player)
end