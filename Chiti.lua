-- Вставляйте этот скрипт в ServerScriptService или командную строку Studio

local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

-- Функция для клонирования объекта и всех его потомков
local function cloneObject(obj, parent)
    local clone = obj:Clone()
    clone.Parent = parent
    return clone
end

-- Функция для рекурсивного копирования всей структуры папок и скриптов
local function copyFolderContents(source, destination)
    for _, child in ipairs(source:GetChildren()) do
        if child:IsA("Folder") or child:IsA("Script") or child:IsA("LocalScript") or child:IsA("ModuleScript") or child:IsA("ServerScript") or child:IsA("Model") or child:IsA("Part") then
            local newChild = cloneObject(child, destination)
            
            -- Если это папка, рекурсивно копируем её содержимое
            if child:IsA("Folder") then
                copyFolderContents(child, newChild)
            end
        end
    end
end

-- Основная функция
local function copyServerScriptServiceToWorkspace()
    -- Создаем папку в Workspace если её нет
    local targetFolder = Workspace:FindFirstChild("SscrServ")
    if not targetFolder then
        targetFolder = Instance.new("Folder")
        targetFolder.Name = "SscrServ"
        targetFolder.Parent = Workspace
        print("Создана папка SscrServ в Workspace")
    else
        -- Очищаем существующую папку
        targetFolder:ClearAllChildren()
        print("Очищена существующая папка SscrServ")
    end
    
    -- Копируем содержимое ServerScriptService
    copyFolderContents(ServerScriptService, targetFolder)
    
    print("Содержимое ServerScriptService успешно скопировано в Workspace.SscrServ")
    print("Скопировано объектов: " .. #targetFolder:GetDescendants())
end

-- Запускаем копирование
copyServerScriptServiceToWorkspace()