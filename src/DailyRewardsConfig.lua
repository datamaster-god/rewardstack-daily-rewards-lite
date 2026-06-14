-- RewardStack Daily Rewards Lite v1.0
-- Soporte y comunidad: discord.gg/E4Q3HtWkG
-- Codigo limpio, sin backdoors, soporte activo

local DailyRewardsConfig = {}

-- Nombre de la moneda que se mostrara en la UI
DailyRewardsConfig.CurrencyName = "Coins"

-- Recompensas por dia (ciclo de 7 dias)
DailyRewardsConfig.Rewards = {
    [1] = 100,
    [2] = 150,
    [3] = 200,
    [4] = 300,
    [5] = 400,
    [6] = 500,
    [7] = 750,
}

-- Tiempo minimo entre claims (segundos)
DailyRewardsConfig.ClaimCooldownSeconds = 24 * 60 * 60  -- 24 horas

-- Tiempo maximo antes de resetear el streak (segundos)
DailyRewardsConfig.ResetStreakAfterSeconds = 48 * 60 * 60  -- 48 horas

-- UI (editable en Lite)
DailyRewardsConfig.UI = {
    Title = "Daily Rewards",
    BackgroundColor = Color3.fromRGB(28, 28, 33),
    PrimaryColor = Color3.fromRGB(90, 210, 150),
    ButtonColor = Color3.fromRGB(45, 170, 110),
    -- PRO: FontFamily, Theme ("dark"/"light"/"custom"), AnimationStyle, IconPack
}

return DailyRewardsConfig
