while true do
    game:FindFirstChild("SurgePart"):Destroy();
    game:FindFirstChild("Pebbles"):Destroy();
    game:FindFirstChild("Caws"):Destroy();
    game:FindFirstChild("LiveClientCaw"):Destroy();
    game:FindFirstChild("Flowers"):Destroy();
    game:FindFirstChild("GrassSign"):Destroy();
    game:FindFirstChild("GrassTuft"):Destroy();
    game:FindFirstChild("SurgePart"):Destroy();
end
--[[
local function removeObject(name, type)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA(type) and obj.Name == name then
            obj:Destroy()
        end
    end
end

local objectNames = {
    "SurgePart",
    "TreeCellGroup",
    "Leaves",
    "Flowers",
    "Pebbles",
    "Caws",
    "LiveClientCaw",
    "GrassTuft",
    "GrassSign",
    "Twine",
    "Weeds",
    "Shrubs",
    "Bush",
    "Dust"
}
local objectTypes = {
    Mesh,
    Model,
    Part,
    Folder
}

while true do
    for _, name in pairs(objectNames) do
        for _, type in pairs(objectTypes) do
            removeObject(name, type)
        end
    end
    wait(1)
end
--]]
