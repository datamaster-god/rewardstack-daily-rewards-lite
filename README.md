# RewardStack Daily Rewards Lite

**Free daily rewards kit for Roblox developers.**

Clean code · No backdoors · Active support

> **Support & Community:** [discord.gg/E4Q3HtWkG](https://discord.gg/E4Q3HtWkG)

---

## Features

- 7-day streak tracker with visual circle UI
- DataStore persistence (streak + last claim)
- 24h cooldown with automatic streak reset at 48h
- Pop-in animation with UIScale
- Claim animation + sound feedback
- One-click installer script
- Fully configurable via `DailyRewardsConfig`

---

## Installation

### Step 1 — Add the Model
Insert `RewardStack_DailyRewardsLite` into **ReplicatedStorage**.

### Step 2 — Run the Installer
1. Move `Docs/RewardStack_Install` to **ServerScriptService**
2. Press **Play** once in Roblox Studio
3. Check the Output — you should see:
   ```
   [RewardStack] RewardStack_Loader instalado en ServerScriptService
   [RewardStack] RewardStack_ClientLoader instalado en StarterPlayerScripts
   [RewardStack] Instalacion completa.
   ```
4. Press **Stop**
5. Delete `RewardStack_Install` from ServerScriptService

### Step 3 — Enable DataStore API
Go to **File → Game Settings → Security** and enable **"Enable Studio Access to API Services"**.

### Step 4 — Play
Press Play. The Daily Rewards popup will appear automatically.

---

## Configuration

Open `ReplicatedStorage/RewardStack_DailyRewardsLite/Config/DailyRewardsConfig` to customize:

```lua
DailyRewardsConfig.CurrencyName = "Coins"      -- Your currency name

DailyRewardsConfig.Rewards = {
    [1] = 100, [2] = 150, [3] = 200, [4] = 300,
    [5] = 400, [6] = 500, [7] = 750,
}

DailyRewardsConfig.ClaimCooldownSeconds = 24 * 60 * 60   -- 24 hours
DailyRewardsConfig.ResetStreakAfterSeconds = 48 * 60 * 60 -- 48 hours

DailyRewardsConfig.UI = {
    Title = "Daily Rewards",
    BackgroundColor = Color3.fromRGB(28, 28, 33),
    PrimaryColor = Color3.fromRGB(90, 210, 150),
    ButtonColor = Color3.fromRGB(45, 170, 110),
}
```

---

## Folder Structure

```
ReplicatedStorage/
  RewardStack_DailyRewardsLite/
    Config/
      DailyRewardsConfig     ← edit rewards & UI here
    Remotes/
      ClaimReward            ← RemoteEvent
      GetRewardData          ← RemoteFunction
    Docs/
      RewardStack_Loader         ← server script
      RewardStack_ClientLoader   ← client script + UI
      RewardStack_Install        ← one-time installer

ServerScriptService/
  RewardStack_Loader         ← placed by installer

StarterPlayerScripts/
  RewardStack_ClientLoader   ← placed by installer
```

---

## Pro Version

Looking for more features? The **Pro version** includes:

- 3 tracker styles (circles, cards, calendar)
- 14-day and 30-day cycle options
- Per-day animations and effects
- Theme system (dark / light / custom)
- Icon pack support
- Multi-currency integration

> Coming soon on Gumroad.

---

## License

Free to use in any Roblox game. Do not resell or redistribute as your own.

---

*Made by [RewardStack](https://discord.gg/E4Q3HtWkG)*
