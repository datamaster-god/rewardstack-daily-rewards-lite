-- RewardStack Daily Rewards Lite v1.0
-- Soporte: discord.gg/E4Q3HtWkG
-- Ubicacion: StarterPlayerScripts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local root = ReplicatedStorage:WaitForChild("RewardStack_DailyRewardsLite")
local Remotes = root.Remotes

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DailyRewardsGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 320)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Visible = false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

local uiScale = Instance.new("UIScale")
uiScale.Scale = 0
uiScale.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 44)
title.Position = UDim2.new(0, 0, 0, 8)
title.BackgroundTransparency = 1
title.Text = "Daily Rewards"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
closeBtn.Text = "x"
closeBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    uiScale.Scale = 0
end)

-- Day label
local dayLabel = Instance.new("TextLabel")
dayLabel.Size = UDim2.new(1, 0, 0, 32)
dayLabel.Position = UDim2.new(0, 0, 0, 54)
dayLabel.BackgroundTransparency = 1
dayLabel.TextColor3 = Color3.fromRGB(90, 210, 150)
dayLabel.TextSize = 24
dayLabel.Font = Enum.Font.GothamBold
dayLabel.Parent = frame

-- Streak tracker: 7 visual circles
local CIRCLE_SIZE = 28
local CIRCLE_GAP = 12
local circlesFrame = Instance.new("Frame")
circlesFrame.Size = UDim2.new(1, -32, 0, 32)
circlesFrame.Position = UDim2.new(0, 16, 0, 92)
circlesFrame.BackgroundTransparency = 1
circlesFrame.Parent = frame

local circles = {}
for i = 1, 7 do
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, CIRCLE_SIZE, 0, CIRCLE_SIZE)
    circle.AnchorPoint = Vector2.new(0.5, 0.5)
    circle.Position = UDim2.new(0, 14 + (i-1) * (CIRCLE_SIZE + CIRCLE_GAP), 0.5, 0)
    circle.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
    circle.BorderSizePixel = 0
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)
    circle.Parent = circlesFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = tostring(i)
    label.TextColor3 = Color3.fromRGB(100, 100, 110)
    label.TextSize = 11
    label.Font = Enum.Font.GothamBold
    label.Parent = circle

    circles[i] = { frame = circle, label = label }
end

-- Reward label
local rewardLabel = Instance.new("TextLabel")
rewardLabel.Size = UDim2.new(1, 0, 0, 26)
rewardLabel.Position = UDim2.new(0, 0, 0, 134)
rewardLabel.BackgroundTransparency = 1
rewardLabel.TextColor3 = Color3.fromRGB(255, 200, 80)
rewardLabel.TextSize = 16
rewardLabel.Font = Enum.Font.GothamBold
rewardLabel.Parent = frame

-- Claim button
local claimButton = Instance.new("TextButton")
claimButton.Size = UDim2.new(1, -32, 0, 44)
claimButton.Position = UDim2.new(0, 16, 0, 172)
claimButton.BackgroundColor3 = Color3.fromRGB(45, 170, 110)
claimButton.Text = "Reclamar recompensa"
claimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
claimButton.TextSize = 15
claimButton.Font = Enum.Font.GothamBold
claimButton.BorderSizePixel = 0
Instance.new("UICorner", claimButton).CornerRadius = UDim.new(0, 10)
claimButton.Parent = frame

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 226)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(130, 130, 140)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- Streak label
local streakLabel = Instance.new("TextLabel")
streakLabel.Size = UDim2.new(1, 0, 0, 22)
streakLabel.Position = UDim2.new(0, 0, 0, 254)
streakLabel.BackgroundTransparency = 1
streakLabel.TextColor3 = Color3.fromRGB(255, 140, 50)
streakLabel.TextSize = 12
streakLabel.Font = Enum.Font.Gotham
streakLabel.Parent = frame

-- Sound
local claimSound = Instance.new("Sound")
claimSound.SoundId = "rbxassetid://9120386436"
claimSound.Volume = 0.5
claimSound.Parent = frame

-- Logic
local lastData = nil

local function updateCircles(currentDay, canClaim)
    for i = 1, 7 do
        local c = circles[i]
        local stroke = c.frame:FindFirstChildOfClass("UIStroke")
        if stroke then stroke:Destroy() end

        if i < currentDay then
            c.frame.BackgroundColor3 = Color3.fromRGB(40, 130, 85)
            c.label.TextColor3 = Color3.fromRGB(255, 255, 255)
        elseif i == currentDay then
            c.frame.BackgroundColor3 = canClaim
                and Color3.fromRGB(90, 210, 150)
                or Color3.fromRGB(40, 130, 85)
            c.label.TextColor3 = Color3.fromRGB(255, 255, 255)
            local s = Instance.new("UIStroke", c.frame)
            s.Color = Color3.fromRGB(255, 255, 255)
            s.Thickness = 1.5
            s.Transparency = 0.4
        else
            c.frame.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
            c.label.TextColor3 = Color3.fromRGB(100, 100, 110)
        end
    end
end

local function refreshUI()
    local data = Remotes.GetRewardData:InvokeServer()
    lastData = data

    dayLabel.Text = "Dia " .. data.day .. " de 7"
    rewardLabel.Text = data.reward .. " " .. data.currencyName
    streakLabel.Text = "Racha: " .. data.streak .. (data.streak == 1 and " dia" or " dias")

    updateCircles(data.day, data.canClaim)

    if data.canClaim then
        claimButton.BackgroundColor3 = Color3.fromRGB(45, 170, 110)
        claimButton.Text = "Reclamar recompensa"
        claimButton.Active = true
        statusLabel.Text = ""
    else
        claimButton.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
        claimButton.Text = "Ya reclamaste hoy"
        claimButton.Active = false
        statusLabel.Text = "Vuelve manana para tu proxima recompensa."
    end

    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Visible = true
    uiScale.Scale = 0
    TweenService:Create(uiScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1,
    }):Play()
end

claimButton.MouseButton1Click:Connect(function()
    if not claimButton.Active or not lastData then return end

    Remotes.ClaimReward:FireServer()
    claimSound:Play()

    local c = circles[lastData.day]
    if c then
        TweenService:Create(c.frame, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 38, 0, 38)
        }):Play()
        task.wait(0.2)
        TweenService:Create(c.frame, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, CIRCLE_SIZE, 0, CIRCLE_SIZE)
        }):Play()
    end

    task.wait(0.4)
    refreshUI()
end)

task.wait(0.3)
refreshUI()
