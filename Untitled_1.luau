-- LocalScript: zet dit in StarterPlayer > StarterPlayerScripts (of StarterGui)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local TARGET_POSITION = Vector3.new(15994, 6, 12)
local BACK_POSITION = Vector3.new(-464, 30, -959)
local ADMIN_POSITION = Vector3.new(628, 43, 13093)
local TOGGLE_KEY = Enum.KeyCode.BackSlash -- de \ toets

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GratisTPGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Hoofdframe (versleepbaar)
local frame = Instance.new("Frame")
frame.Name = "Hoofdframe"
frame.Size = UDim2.new(0, 200, 0, 233)
frame.Position = UDim2.new(0.5, -100, 0.6, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame

-- Titelbalk (hier sleep je aan)
local titleBar = Instance.new("TextLabel")
titleBar.Name = "Titelbalk"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0
titleBar.Text = "Teleport  ( \\ = aan/uit )"
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 14
titleBar.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Knop: Gratis TP (geel)
local button = Instance.new("TextButton")
button.Name = "GratisTPKnop"
button.Text = "Gratis TP"
button.Size = UDim2.new(1, -30, 0, 50)
button.Position = UDim2.new(0, 15, 0, 45)
button.BackgroundColor3 = Color3.fromRGB(255, 221, 0)
button.TextColor3 = Color3.fromRGB(0, 0, 0)
button.Font = Enum.Font.GothamBold
button.TextSize = 22
button.BorderSizePixel = 0
button.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = button

-- Knop: ga terug
local backButton = Instance.new("TextButton")
backButton.Name = "GaTerugKnop"
backButton.Text = "ga terug"
backButton.Size = UDim2.new(1, -30, 0, 50)
backButton.Position = UDim2.new(0, 15, 0, 108)
backButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
backButton.TextColor3 = Color3.fromRGB(0, 0, 0)
backButton.Font = Enum.Font.GothamBold
backButton.TextSize = 22
backButton.BorderSizePixel = 0
backButton.Parent = frame

local backCorner = Instance.new("UICorner")
backCorner.CornerRadius = UDim.new(0, 10)
backCorner.Parent = backButton

-- Knop: admin tp (rood)
local adminButton = Instance.new("TextButton")
adminButton.Name = "AdminTPKnop"
adminButton.Text = "admin tp"
adminButton.Size = UDim2.new(1, -30, 0, 50)
adminButton.Position = UDim2.new(0, 15, 0, 171)
adminButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
adminButton.TextColor3 = Color3.fromRGB(255, 255, 255)
adminButton.Font = Enum.Font.GothamBold
adminButton.TextSize = 22
adminButton.BorderSizePixel = 0
adminButton.Parent = frame

local adminCorner = Instance.new("UICorner")
adminCorner.CornerRadius = UDim.new(0, 10)
adminCorner.Parent = adminButton

-- Teleport
local function teleportTo(position)
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:FindFirstChild("HumanoidRootPart")
	if root then
		root.CFrame = CFrame.new(position)
	end
end

button.MouseButton1Click:Connect(function()
	teleportTo(TARGET_POSITION)
end)

backButton.MouseButton1Click:Connect(function()
	teleportTo(BACK_POSITION)
end)

adminButton.MouseButton1Click:Connect(function()
	teleportTo(ADMIN_POSITION)
end)

-- Slepen (muis en touch)
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- Aan/uit met de \ toets
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == TOGGLE_KEY then
		frame.Visible = not frame.Visible
	end
end)
