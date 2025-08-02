local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

_G.TeleportEnabled = false
_G.TeleportDelay = 2

local function ShowNotification(title, text, duration)
    duration = duration or 5
    local notificationGui = Instance.new("ScreenGui", game.CoreGui)
    notificationGui.Name = "NotificationUI"
    notificationGui.ResetOnSpawn = false

    local frame = Instance.new("Frame", notificationGui)
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(1, -320, 1, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 10)
    titleLabel.Size = UDim2.new(1, -30, 0, 20)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Text = text
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 14
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel.BackgroundTransparency = 1
    textLabel.Position = UDim2.new(0, 15, 0, 35)
    textLabel.Size = UDim2.new(1, -30, 0, 35)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.TextWrapped = true

    task.spawn(function()
        task.wait(duration)
        notificationGui:Destroy()
    end)
end

ShowNotification("CraftCodeLua", "The Extreme Obby UI loaded successfully!")

-- Create main GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ExtremeObbyUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 190)
frame.Position = UDim2.new(0.5, -125, 0.5, -95)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Text = "The Extreme Obby"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 10, 0, 6)
title.Size = UDim2.new(1, -20, 0, 20)
title.TextXAlignment = Enum.TextXAlignment.Left

local subtitle = Instance.new("TextLabel", frame)
subtitle.Text = "script by craftcodelua"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 10, 0, 26)
subtitle.Size = UDim2.new(1, -20, 0, 20)
subtitle.TextXAlignment = Enum.TextXAlignment.Left

local teleportBtn = Instance.new("TextButton", frame)
teleportBtn.Text = "Teleport: OFF"
teleportBtn.Font = Enum.Font.Gotham
teleportBtn.TextSize = 14
teleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
teleportBtn.Position = UDim2.new(0, 10, 0, 55)
teleportBtn.Size = UDim2.new(1, -20, 0, 25)
Instance.new("UICorner", teleportBtn).CornerRadius = UDim.new(0, 6)

teleportBtn.MouseButton1Click:Connect(function()
    _G.TeleportEnabled = not _G.TeleportEnabled
    teleportBtn.Text = "Teleport: " .. (_G.TeleportEnabled and "ON" or "OFF")
end)

local delayLabel = Instance.new("TextLabel", frame)
delayLabel.Text = "Teleport Delay"
delayLabel.Font = Enum.Font.Gotham
delayLabel.TextSize = 14
delayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
delayLabel.BackgroundTransparency = 1
delayLabel.Position = UDim2.new(0, 10, 0, 90)
delayLabel.Size = UDim2.new(1, -20, 0, 20)
delayLabel.TextXAlignment = Enum.TextXAlignment.Left

local dropdown = Instance.new("TextButton", frame)
dropdown.Text = "Normal"
dropdown.Font = Enum.Font.Gotham
dropdown.TextSize = 14
dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dropdown.Position = UDim2.new(0, 10, 0, 115)
dropdown.Size = UDim2.new(1, -20, 0, 25)
Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0, 6)

local options = {"Slow", "Normal", "Fast"}
local delays = {["Slow"] = 3, ["Normal"] = 2, ["Fast"] = 1}
local index = 2

dropdown.MouseButton1Click:Connect(function()
    index = index + 1
    if index > #options then index = 1 end
    dropdown.Text = options[index]
    _G.TeleportDelay = delays[options[index]]
end)

local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeBtn.Position = UDim2.new(1, -65, 0, 6)
minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

local minimized = false
local originalSize = frame.Size
local minimizedSize = UDim2.new(0, 250, 0, 40)

minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        frame.Size = minimizedSize
        for _, v in pairs(frame:GetChildren()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                if v ~= title and v ~= minimizeBtn and v ~= closeBtn then
                    v.Visible = false
                end
            end
        end
    else
        frame.Size = originalSize
        for _, v in pairs(frame:GetChildren()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                if v ~= title and v ~= minimizeBtn and v ~= closeBtn then
                    v.Visible = true
                end
            end
        end
    end
end)

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 6)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

task.spawn(function()
    local currentIndex = 0
    while task.wait(1) do
        if _G.TeleportEnabled then
            local cp = workspace:FindFirstChild("Checkpoints")
            if cp then
                local next = cp:FindFirstChild("Checkpoint" .. currentIndex)
                if next then
                    player.Character:PivotTo(next.CFrame + Vector3.new(0, 3, 0))
                    currentIndex += 1
                    task.wait(_G.TeleportDelay)
                else
                    currentIndex = 0
                end
            end
        end
    end
end)
