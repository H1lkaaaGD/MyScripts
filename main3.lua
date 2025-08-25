local Players = game:GetService("Players")

local function setupCharacterAttributes(character)
    character:SetAttribute("CanJump", true)
    print("Атрибут CanJump создан и установлен в true для персонажа", character.Name)
end