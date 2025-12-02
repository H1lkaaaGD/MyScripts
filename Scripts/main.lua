local objectsToRemove = {
    "Pinetree_Optimized",
    "PeskyWeeds",
    "HidingShrub",
    "GrassSign",
    "Flowers",
    "RainStuff",
    "Bush",
    "GrassBorder",
    "GrassTuft",
    "GrassPatch",
    "Pebbles",
    "Dust",
    "CatTails",
    "Seeds",
    "SeedsBag",
    "Twine",
    "Glove",
    "Hat",
    "Pot",
    "PotBroken",
    "TreeGroupCell",
    "BigVase",
    "Clouds",
    "SkyboxPart",
    "Tape",
    "Wrench",
    "Measure",
    "DoubleWrench",
    "FloorGrassPatch",
    "Leaves",
    "Letter",
    "ScewdriverBottom",
    "Leaves1",
    "Leaves2",
    "Leaves3",
    "Vines",
    "Vines_Cut",
    "Thorns",
    "VinesBlockade"
}

-- Таблица для отслеживания уже удаленных объектов
local removedObjects = {}

-- Функция для проверки, является ли объект частью Groundskeeper
function IsPartOfGroundskeeper(obj)
    local current = obj
    while current.Parent ~= nil do
        if current.Name == "Groundskeeper" then
            return true
        end
        current = current.Parent
    end
    return false
end
function ShouldRemoveObject(obj, objectName)
    if (objectName == "Glowe" or objectName == "Hat") and IsPartOfGroundskeeper(obj) then
        return false
    end
    return true
end

-- Функция для поиска объектов только в Workspace
function FindObjectsInWorkspace(name)
    local found = {}
    
    -- Ищем объекты только в Workspace
    local function searchInWorkspace(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.Name == name then
                table.insert(found, child)
            end
            -- Рекурсивно ищем во вложенных папках Workspace
            searchInWorkspace(child)
        end
    end
    
    -- Начинаем поиск с корня Workspace
    searchInWorkspace(game:GetService("Workspace"))
    
    return found
end

-- Функция для безопасного удаления объекта
function SafeDestroy(obj)
    if obj and obj:IsA("Instance") then
        pcall(function()
            obj:Destroy()
        end)
        return true
    end
    return false
end

-- Функция для проверки и удаления объектов только в Workspace
function CheckAndRemoveObjectsInWorkspace()
    local objectsRemoved = false
    
    for _, objectName in ipairs(objectsToRemove) do
        local objects = FindObjectsInWorkspace(objectName)
        
        if #objects > 0 then
            for _, obj in ipairs(objects) do
                -- Проверяем, нужно ли удалять этот объект
                if ShouldRemoveObject(obj, objectName) then
                    if SafeDestroy(obj) then
                        objectsRemoved = true
                        
                        if not removedObjects[objectName] then
                            warn("🗑️ Обнаружен и удален объект в Workspace: " .. objectName)
                            removedObjects[objectName] = true
                        end
                    end
                else
                    warn("⚠️ Объект " .. objectName .. " является частью Groundskeeper и не будет удален")
                end
            end
        else
            removedObjects[objectName] = nil
        end
    end
    
    return objectsRemoved
end

-- Функция для мониторинга новых объектов только в Workspace
function MonitorNewObjectsInWorkspace()
    -- Отслеживаем появление новых объектов только в Workspace
    game:GetService("Workspace").DescendantAdded:Connect(function(descendant)
        -- Проверяем, что объект находится именно в Workspace
        local isInWorkspace = true
        local current = descendant
        while current.Parent ~= nil do
            if current.Parent == game then
                if current ~= workspace then
                    isInWorkspace = false
                end
                break
            end
            current = current.Parent
        end
        
        if isInWorkspace then
            for _, objectName in ipairs(objectsToRemove) do
                if descendant.Name == objectName then
                    -- Проверяем, нужно ли удалять этот объект
                    if ShouldRemoveObject(descendant, objectName) then
                        if SafeDestroy(descendant) then
                            warn("🚨 Новый объект удален из Workspace: " .. objectName)
                        end
                    else
                        warn("⚠️ Новый объект " .. objectName .. " является частью Groundskeeper и не будет удален")
                    end
                end
            end
        end
    end)
end

-- Основная функция запуска
function StartWorkspaceCleaner()
    print("🔍 Запуск очистки объектов в Workspace...")
    print("⚠️ Исключение: Glowe и Hat не удаляются, если являются частью Groundskeeper")
    
    -- Первоначальная очистка
    local removedCount = 0
    for _ = 1, 3 do  -- Несколько проходов для надежности
        if CheckAndRemoveObjectsInWorkspace() then
            removedCount = removedCount + 1
        end
        wait(0.1)
    end
    
    print("✅ Первоначальная очистка Workspace завершена")
    
    -- Запускаем мониторинг новых объектов только в Workspace
    MonitorNewObjectsInWorkspace()
    
    print("👁️ Мониторинг новых объектов в Workspace активен")
    
    -- Постоянный мониторинг (опционально)
    while true do
        CheckAndRemoveObjectsInWorkspace()
        wait(5)  -- Проверка каждые 5 секунд
    end
end

-- Упрощенная версия без постоянного цикла
function StartSimpleWorkspaceMonitor()
    print("🔍 Запуск мониторинга Workspace...")
    print("⚠️ Исключение: Glowe и Hat не удаляются, если являются частью Groundskeeper")
    
    -- Однократная очистка при запуске
    CheckAndRemoveObjectsInWorkspace()
    
    -- Мониторинг только новых объектов
    game:GetService("Workspace").DescendantAdded:Connect(function(descendant)
        for _, objectName in ipairs(objectsToRemove) do
            if descendant.Name == objectName then
                -- Проверяем, нужно ли удалять этот объект
                if ShouldRemoveObject(descendant, objectName) then
                    if SafeDestroy(descendant) then
                        warn("🚨 Удален новый объект в Workspace: " .. objectName)
                    end
                else
                    warn("⚠️ Новый объект " .. objectName .. " является частью Groundskeeper и не будет удален")
                end
            end
        end
    end)
    
    print("✅ Мониторинг Workspace активен")
end

-- Защита от повторного запуска
if not _G.WorkspaceCleanerRunning then
    _G.WorkspaceCleanerRunning = true
    
    -- Запускаем в отдельной корутине
    local success, error = pcall(function()
        StartSimpleWorkspaceMonitor()  -- Простой мониторинг
    end)
    
    if not success then
        warn("❌ Ошибка в очистке Workspace: " .. tostring(error))
        _G.WorkspaceCleanerRunning = false
    end
else
    print("⚠️ Очистка Workspace уже запущена")
end