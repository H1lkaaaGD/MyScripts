local Lighting = game:GetService("Lighting")
local function deleteObjectsExceptSky()
    for _, object in pairs(Lighting:GetChildren()) do
        if object.Name ~= "Sky" then
            object:Destroy()
        end
    end
end
local function setLightingSettings()
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.Brightness = 1
end
local function onChildAdded(child)
    if child.Name ~= "Sky" then
        child:Destroy()
    end
end
Lighting.ChildAdded:Connect(onChildAdded)
while true do
    deleteObjectsExceptSky()
    setLightingSettings()
    wait(0.1)
end