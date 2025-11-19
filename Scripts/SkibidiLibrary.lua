local BookCleanup = {}

-- Конфигурация
BookCleanup.TargetParentNames = {"Module_LibraryRoomPuzzle", "Modular_Bookshelf"}
BookCleanup.ObjectsToDelete = {"Books", "Base"}
BookCleanup.CheckInterval = 1 -- Интервал проверки в секундах
BookCleanup.RunOnStart = true

-- Основная функция очистки
function BookCleanup.CleanupObjects()
    local foundObjects = false
    
    for _, parentName in ipairs(BookCleanup.TargetParentNames) do
        -- Ищем родительские объекты
        local parents = game:GetService("Workspace"):FindFirstChild(parentName)
        if parents then
            -- Если найден один объект
            if parents:IsA("Model") or parents:IsA("Part") then
                BookCleanup.CheckChildren(parents)
                foundObjects = true
            -- Если это папка с несколькими объектами
            elseif parents:IsA("Folder") then
                for _, child in ipairs(parents:GetChildren()) do
                    BookCleanup.CheckChildren(child)
                    foundObjects = true
                end
            end
        end
    end
    
    if foundObjects then
        print("Проверка объектов завершена")
    end
end

-- Функция проверки дочерних объектов
function BookCleanup.CheckChildren(parent)
    for _, objectName in ipairs(BookCleanup.ObjectsToDelete) do
        local objectToDelete = parent:FindFirstChild(objectName)
        if objectToDelete then
            objectToDelete:Destroy()
            print("Удален объект: " .. objectName .. " из " .. parent.Name)
        end
    end
end

-- Запуск скрипта
if BookCleanup.RunOnStart then
    BookCleanup.CleanupObjects()
end

-- Периодическая проверка
if BookCleanup.CheckInterval > 0 then
    while true do
        wait(BookCleanup.CheckInterval)
        BookCleanup.CleanupObjects()
    end
end

return BookCleanup