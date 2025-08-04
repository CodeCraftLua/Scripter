local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "HyperShotUI"
screenGui.ResetOnSpawn = false

local title = Instance.new("TextLabel", screenGui)
title.Size = UDim2.new(0, 200, 0, 30)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Text = "HyperShot"
title.TextColor3 = Color3.fromRGB(255, 150, 0)

local border = Instance.new("Frame", screenGui)
border.Size = UDim2.new(0, 240, 0, 250)
border.Position = UDim2.new(0, 10, 0, 50)
border.BorderSizePixel = 2
border.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
border.Active = true
border.Draggable = true
border.ClipsDescendants = true

local scroll = Instance.new("ScrollingFrame", border)
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local aimbotButton = Instance.new("TextButton", scroll)
aimbotButton.Size = UDim2.new(1, -20, 0, 40)
aimbotButton.Position = UDim2.new(0, 10, 0, 10)
aimbotButton.Text = "Aimbot: OFF"
aimbotButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
aimbotButton.TextColor3 = Color3.new(1, 1, 1)
aimbotButton.Font = Enum.Font.SourceSansBold
aimbotButton.TextSize = 18

local partButton = Instance.new("TextButton", scroll)
partButton.Size = UDim2.new(1, -20, 0, 40)
partButton.Position = UDim2.new(0, 10, 0, 60)
partButton.Text = "Aim Part: HEAD"
partButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
partButton.TextColor3 = Color3.new(1, 1, 1)
partButton.Font = Enum.Font.SourceSansBold
partButton.TextSize = 18

local credit = Instance.new("TextLabel", scroll)
credit.Size = UDim2.new(1, -20, 0, 30)
credit.Position = UDim2.new(0, 10, 0, 110)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(200, 200, 200)
credit.Text = "Made By TrollScripter"
credit.Font = Enum.Font.SourceSansItalic
credit.TextSize = 14

local aimbotEnabled = false
local aimPart = "Head"

aimbotButton.MouseButton1Click:Connect(function()
	aimbotEnabled = not aimbotEnabled
	aimbotButton.Text = aimbotEnabled and "Aimbot: ON" or "Aimbot: OFF"
end)

partButton.MouseButton1Click:Connect(function()
	aimPart = (aimPart == "Head") and "HumanoidRootPart" or "Head"
	partButton.Text = "Aim Part: " .. (aimPart == "Head" and "HEAD" or "BODY")
end)

local function getClosestPlayer()
	local closest, shortest = nil, math.huge
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and player.Character and player.Character:FindFirstChild(aimPart) then
			local pos, onScreen = Camera:WorldToViewportPoint(player.Character[aimPart].Position)
			if onScreen then
				local dist = (Camera.CFrame.Position - player.Character[aimPart].Position).Magnitude
				if dist < shortest then
					shortest = dist
					closest = player
				end
			end
		end
	end
	return closest
end

RunService.RenderStepped:Connect(function()
	if aimbotEnabled then
		local target = getClosestPlayer()
		if target and target.Character and target.Character:FindFirstChild(aimPart) then
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character[aimPart].Position)
		end
	end
end)

local function createESP(player)
	local box = Drawing.new("Square")
	box.Thickness = 2
	box.Transparency = 1
	box.Color = Color3.fromRGB(255, 255, 255)
	box.Filled = false

	local healthbar = Drawing.new("Square")
	healthbar.Thickness = 1
	healthbar.Filled = true
	healthbar.Color = Color3.fromRGB(0, 255, 0)

	RunService.RenderStepped:Connect(function()
		if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
			local pos, vis = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
			if vis then
				local size = 50 / (player.Character.HumanoidRootPart.Position - Camera.CFrame.Position).Magnitude * 100
				box.Size = Vector2.new(size, size * 1.5)
				box.Position = Vector2.new(pos.X - size / 2, pos.Y - size * 0.75)
				box.Visible = true

				local hpRatio = player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth
				healthbar.Size = Vector2.new(size * hpRatio, 4)
				healthbar.Position = Vector2.new(pos.X - size / 2, pos.Y + size * 0.75 + 2)
				healthbar.Visible = true
			else
				box.Visible = false
				healthbar.Visible = false
			end
		else
			box.Visible = false
			healthbar.Visible = false
		end
	end)
end

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
		createESP(player)
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		wait(1)
		if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
			createESP(player)
		end
	end)
end)

local t = 0
RunService.RenderStepped:Connect(function()
	t = t + 0.02
	local r = 255
	local g = math.floor(150 + math.sin(t) * 105)
	local b = 0
	title.TextColor3 = Color3.fromRGB(r, g, b)
end)
