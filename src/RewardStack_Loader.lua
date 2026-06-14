-- RewardStack Daily Rewards Lite v1.0
-- Soporte: discord.gg/E4Q3HtWkG
-- Ubicacion: ServerScriptService

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local root = ReplicatedStorage:WaitForChild("RewardStack_DailyRewardsLite")
local Config = require(root:WaitForChild("Config"):WaitForChild("DailyRewardsConfig"))
local Remotes = root:WaitForChild("Remotes")
local ClaimReward = Remotes:WaitForChild("ClaimReward")
local GetRewardData = Remotes:WaitForChild("GetRewardData")

local dataStore = DataStoreService:GetDataStore("RewardStack_DailyRewards_v1")

local function getPlayerData(userId)
    local success, data = pcall(function()
        return dataStore:GetAsync(tostring(userId))
    end)
    if success and data then return data end
    return { streak = 0, lastClaim = 0 }
end

local function savePlayerData(userId, data)
    pcall(function()
        dataStore:SetAsync(tostring(userId), data)
    end)
end

local function getReward(streak)
    local day = (streak % 7) + 1
    return Config.Rewards[day] or Config.Rewards[1]
end

GetRewardData.OnServerInvoke = function(player)
    local data = getPlayerData(player.UserId)
    local day = (data.streak % 7) + 1
    local canClaim = os.time() - data.lastClaim >= Config.ClaimCooldownSeconds
    return {
        streak = data.streak,
        day = day,
        canClaim = canClaim,
        reward = getReward(data.streak),
        currencyName = Config.CurrencyName,
    }
end

ClaimReward.OnServerEvent:Connect(function(player)
    local data = getPlayerData(player.UserId)
    local now = os.time()

    if now - data.lastClaim < Config.ClaimCooldownSeconds then return end

    if data.lastClaim ~= 0 and now - data.lastClaim >= Config.ResetStreakAfterSeconds then
        data.streak = 0
    end

    local reward = getReward(data.streak)
    data.streak = data.streak + 1
    data.lastClaim = now

    savePlayerData(player.UserId, data)
    print("[RewardStack] " .. player.Name .. " reclamó Día " .. data.streak .. ": " .. reward .. " " .. Config.CurrencyName)
end)

print("[RewardStack] Daily Rewards Lite v1.0 | Soporte: discord.gg/E4Q3HtWkG")
