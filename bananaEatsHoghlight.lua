local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local function createHighlight(part, fillColor, outlineColor, transparency)
    local highlight = Instance.new("Highlight")
    highlight.FillColor = fillColor
    highlight.OutlineColor = outlineColor
    highlight.FillTransparency = transparency
    highlight.Parent = part
    return highlight
end

local function isLocalPlayerName(name)
    return name == localPlayer.Name
end

local highlightedParts = {}
local function updateHighlights()
    -- GameBananas highlight
    local gameBananas = game.Workspace:FindFirstChild("GameBananas")
    if gameBananas and not highlightedParts[gameBananas] and not isLocalPlayerName(gameBananas.Name) then
        highlightedParts[gameBananas] = createHighlight(gameBananas, Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 0, 0), 0.6)
    elseif gameBananas and highlightedParts[gameBananas] and isLocalPlayerName(gameBananas.Name) then
        highlightedParts[gameBananas]:Destroy()
        highlightedParts[gameBananas] = nil
    end

    -- Token highlight
    local gameKeeper = game.Workspace:FindFirstChild("GameKeeper")
    if gameKeeper then
        local map = gameKeeper:FindFirstChild("Map")
        if map then
            local tokens = map:FindFirstChild("Tokens")
            if tokens then
                local token = tokens:FindFirstChild("Token")
                if token and not highlightedParts[token] and not isLocalPlayerName(token.Name) then
                    highlightedParts[token] = createHighlight(token, Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 255, 0), 0.6)
                elseif token and highlightedParts[token] and isLocalPlayerName(token.Name) then
                    highlightedParts[token]:Destroy()
                    highlightedParts[token] = nil
                end
            end
        end
    end

    -- Check all highlighted parts and remove if needed
    for part, highlight in pairs(highlightedParts) do
        if not part:IsDescendantOf(game.Workspace) or isLocalPlayerName(part.Name) then
            highlight:Destroy()
            highlightedParts[part] = nil
        end
    end
end

-- Wait for game to load and local player
game:IsLoaded() or game.Loaded:Wait()
localPlayer = Players.LocalPlayer

-- Create initial highlights
updateHighlights()

-- Set up recurring check every 0.3 seconds
while true do
    wait(0.3)
    updateHighlights()
end