-- EggESPLoader.lua

local eggConfigs = {
    ["Bug Egg"] = {
        color = Color3.fromRGB(255, 105, 180),
        label = "🐞 Bug Egg"
    },
    ["Zen Egg"] = {
        color = Color3.fromRGB(0, 255, 255),
        label = "🧘 Zen Egg"
    }
}

local function applyESP(egg, config)
    if not egg:IsA("Model") then return end

    local highlight = Instance.new("Highlight")
    highlight.Adornee = egg
    highlight.FillColor = config.color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = egg

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "EggESPLabel"
    billboard.Adornee = egg:FindFirstChild("Head") or egg:FindFirstChildWhichIsA("BasePart")
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = egg

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = config.label
    textLabel.TextColor3 = config.color
    textLabel.BackgroundTransparency = 1
    textLabel.TextStrokeTransparency = 0
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboard
end

local function setupESP()
    local folder = workspace:FindFirstChild("Eggs")
    if not folder then return end

    for _, egg in ipairs(folder:GetChildren()) do
        local cfg = eggConfigs[egg.Name]
        if cfg then
            applyESP(egg, cfg)
        end
    end

    folder.ChildAdded:Connect(function(egg)
        local cfg = eggConfigs[egg.Name]
        if cfg then
            applyESP(egg, cfg)
        end
    end)
end


setupESP()
