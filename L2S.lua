-- Codex Executor Script для автоматического изменения RunContext серверных скриптов
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")

-- Таблица для отслеживания уже обработанных скриптов
local processedScripts = {}

-- Функция для проверки и изменения RunContext
local function fixScriptRunContext(script)
    if script:IsA("Script") and not script:IsA("LocalScript") then
        if script.RunContext == Enum.RunContext.Legacy then
            -- Сохраняем информацию о скрипте перед изменением
            local scriptInfo = {
                Name = script.Name,
                Path = script:GetFullName(),
                OldRunContext = "Legacy"
            }
            
            -- Меняем RunContext на Server
            pcall(function()
                script.RunContext = Enum.RunContext.Server
                scriptInfo.NewRunContext = "Server"
                scriptInfo.Success = true
            end)
            
            -- Добавляем в таблицу обработанных
            processedScripts[script] = scriptInfo
            
            print("✅ Исправлен скрипт: " .. script:GetFullName() .. " (Legacy → Server)")
            return true
        end
    end
    return false
end

-- Функция для поиска скриптов в контейнере
local function scanContainer(container)
    local fixedCount = 0
    
    -- Рекурсивно ищем все скрипты
    local function recursiveScan(object)
        for _, child in ipairs(object:GetChildren()) do
            if fixScriptRunContext(child) then
                fixedCount = fixedCount + 1
            end
            recursiveScan(child)
        end
    end
    
    recursiveScan(container)
    return fixedCount
end

-- Основная функция сканирования
local function scanAllScripts()
    print("🔍 Начинаем сканирование серверных скриптов...")
    
    local totalFixed = 0
    
    -- Сканируем основные серверные контейнеры
    local containers = {
        ServerScriptService,
        ServerStorage,
        Workspace,
        game:GetService("ReplicatedFirst"),
        game:GetService("ReplicatedStorage"),
        game:GetService("StarterPlayer"):GetChildren(),
        game:GetService("StarterPack"),
        game:GetService("StarterGui")
    }
    
    for _, container in ipairs(containers) do
        if typeof(container) == "Instance" then
            totalFixed = totalFixed + scanContainer(container)
        elseif type(container) == "table" then
            for _, item in ipairs(container) do
                totalFixed = totalFixed + scanContainer(item)
            end
        end
    end
    
    -- Сканируем скрипты игроков (если есть)
    for _, player in ipairs(Players:GetPlayers()) do
        totalFixed = totalFixed + scanContainer(player)
    end
    
    print("📊 Сканирование завершено. Исправлено скриптов: " .. totalFixed)
    return totalFixed
end

-- Функция для отслеживания новых скриптов
local function setupScriptTracker()
    local function onChildAdded(child)
        -- Ждем немного чтобы скрипт полностью загрузился
        wait(0.1)
        
        if fixScriptRunContext(child) then
            print("🆕 Обнаружен и исправлен новый скрипт: " .. child:GetFullName())
        end
        
        -- Устанавливаем отслеживание для дочерних объектов
        child.DescendantAdded:Connect(function(descendant)
            wait(0.1)
            if fixScriptRunContext(descendant) then
                print("🆕 Обнаружен и исправлен новый дочерний скрипт: " .. descendant:GetFullName())
            end
        end)
    end
    
    -- Устанавливаем отслеживание для основных контейнеров
    local trackedContainers = {
        ServerScriptService,
        ServerStorage,
        Workspace,
        game:GetService("ReplicatedStorage"),
        game:GetService("StarterPlayer")
    }
    
    for _, container in ipairs(trackedContainers) do
        container.DescendantAdded:Connect(onChildAdded)
        -- Уже существующие объекты
        for _, child in ipairs(container:GetDescendants()) do
            spawn(function()
                onChildAdded(child)
            end)
        end
    end
    
    -- Отслеживаем новых игроков
    Players.PlayerAdded:Connect(function(player)
        player.DescendantAdded:Connect(onChildAdded)
    end)
end

-- Функция для отображения статистики
local function showStats()
    print("\n📈 Статистика обработанных скриптов:")
    local count = 0
    for script, info in pairs(processedScripts) do
        if info.Success then
            count = count + 1
            print(string.format("   %d. %s", count, info.Path))
            print("      " .. info.OldRunContext .. " → " .. info.NewRunContext)
        end
    end
    print("Всего успешно обработано: " .. count .. " скриптов")
end

-- Основной цикл
local function main()
    print("🚀 Codex Executor Script запущен")
    print("📝 Автоматическое исправление RunContext серверных скриптов")
    
    -- Первоначальное сканирование
    scanAllScripts()
    
    -- Настраиваем отслеживание новых скриптов
    setupScriptTracker()
    
    -- Периодическая проверка (каждые 30 секунд)
    while true do
        wait(30)
        local fixed = scanAllScripts()
        if fixed > 0 then
            print("🔄 Периодическая проверка: исправлено " .. fixed .. " скриптов")
        end
    end
end

-- Запуск скрипта
if RunService:IsClient() then
    print("❌ Этот скрипт должен выполняться на сервере!")
else
    -- Создаем интерфейс для управления
    local function createControlPanel()
        -- Команды для чата (если нужно)
        Players.PlayerAdded:Connect(function(player)
            player.Chatted:Connect(function(message)
                if message:lower() == "!fixscripts" and player.UserId == --[[Здесь можно указать ваш UserID для админки]] then
                    scanAllScripts()
                elseif message:lower() == "!scriptstats" and player.UserId == --[[Ваш UserID]] then
                    showStats()
                end
            end)
        end)
    end
    
    createControlPanel()
    main()
end

-- Альтернативная версия для ручного запуска
local function manualStart()
    print("🎯 Ручной запуск исправления скриптов...")
    scanAllScripts()
    showStats()
end

-- Экспорт функций для ручного использования
return {
    Start = main,
    Scan = scanAllScripts,
    Stats = showStats,
    ManualFix = manualStart
}
