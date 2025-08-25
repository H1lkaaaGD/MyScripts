local Lighting = game:GetService("Lighting")

-- Функция для удаления всех объектов в Lighting, кроме Sky
local function deleteObjectsExceptSky()
    for _, object in pairs(Lighting:GetChildren()) do
        if object.Name ~= "Sky" then
            object:Destroy()
        end
    end
end

-- Функция для установки настроек Ambient и Brightness
local function setLightingSettings()
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)  -- Белый цвет
    Lighting.Brightness = 1  -- Яркость 1
end

-- Обработчик для удаления новых объектов
local function onChildAdded(child)
    if child.Name ~= "Sky" then
        child:Destroy()
    end
end

-- Настройка обработчиков событий
Lighting.ChildAdded:Connect(onChildAdded)

-- Бесконечный цикл для поддержания настроек
while true do
    deleteObjectsExceptSky()
    setLightingSettings()
    wait(0.1)  -- Проверка каждые 0.1 секунды
end