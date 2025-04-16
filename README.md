# 🚫 qb-no_dragout

A simple QBCore FiveM resource that prevents players from pulling other players out of vehicles. Optional features include auto-locking vehicle doors and job-based whitelisting for police/EMS.

## ✨ Features
- Prevents carjacking from other players
- Auto-locks vehicle doors when entered
- Job whitelist (e.g. allow police to drag people out)
- Easy config
- Zero dependencies outside of QBCore

## 🔧 Configuration

Edit `config.lua`:

```lua
Config.LockDoors = true

Config.AllowedJobs = {
    ["police"] = true,
    ["ambulance"] = true
}

Config.Debug = false
