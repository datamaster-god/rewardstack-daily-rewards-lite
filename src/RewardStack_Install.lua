-- RewardStack Daily Rewards Lite v1.0 — Installer
-- INSTRUCCIONES:
-- 1. Inserta la carpeta RewardStack_DailyRewardsLite en ReplicatedStorage
-- 2. Mueve este script a ServerScriptService
-- 3. Presiona Play una vez
-- 4. Presiona Stop
-- 5. Elimina este script
-- Soporte: discord.gg/E4Q3HtWkG

local RS = game:GetService("ReplicatedStorage")
local SSS = game:GetService("ServerScriptService")
local SP = game:GetService("StarterPlayer").StarterPlayerScripts

local kit = RS:FindFirstChild("RewardStack_DailyRewardsLite")
if not kit then
    warn("[RewardStack] ERROR: Coloca la carpeta RewardStack_DailyRewardsLite en ReplicatedStorage primero.")
    return
end

local docs = kit:FindFirstChild("Docs")

local loader = docs:FindFirstChild("RewardStack_Loader")
if loader and not SSS:FindFirstChild("RewardStack_Loader") then
    loader:Clone().Parent = SSS
    print("[RewardStack] RewardStack_Loader instalado en ServerScriptService")
else
    print("[RewardStack] RewardStack_Loader ya instalado, saltando.")
end

local clientLoader = docs:FindFirstChild("RewardStack_ClientLoader")
if clientLoader and not SP:FindFirstChild("RewardStack_ClientLoader") then
    clientLoader:Clone().Parent = SP
    print("[RewardStack] RewardStack_ClientLoader instalado en StarterPlayerScripts")
else
    print("[RewardStack] RewardStack_ClientLoader ya instalado, saltando.")
end

print("[RewardStack] Instalacion completa. Elimina RewardStack_Install de ServerScriptService.")
