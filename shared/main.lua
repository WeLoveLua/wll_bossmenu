Config = {}

-- Target system settings
Config.Target = {
    system = "ox_target", -- ox_target, qb-target, bt-target
    distance = 2.0
}

-- Boss menu access settings
Config.BossMenu = {
    grades = {2, 3, 4}, -- Grades that can access boss menu (boss, underboss, etc)
    jobs = {}, -- Leave empty to allow all jobs, or specify jobs like {"police", "ambulance"}
}

-- UI Settings
Config.UI = {
    keybind = "F6", -- Default keybind to open boss menu (if not using target)
    useKeybind = false, -- Set to true to enable keybind access
}

-- Financial settings
Config.Finance = {
    maxWithdraw = 50000, -- Maximum amount that can be withdrawn at once
    maxDeposit = 100000, -- Maximum amount that can be deposited at once
}

-- Player management settings
Config.Players = {
    maxMembers = 50, -- Maximum members per organization
    kickGrace = 24, -- Hours before kicked player can rejoin
}

-- Outfit settings
Config.Outfits = {
    enable = true,
    storageLocation = "wardrobe", -- Where outfits are stored
}

-- Notification settings
Config.Notifications = {
    position = "top-right",
    duration = 5000,
}
