-- Example Target Zone Configurations
-- Copy and paste these into client/main.lua to add multiple boss menu locations

-- Replace the existing ox_target:addBoxZone section with these examples:

-- Police Department Boss Menu
exports.ox_target:addBoxZone({
    coords = vector3(461.45, -986.2, 30.73), -- Mission Row PD
    size = vector3(2, 2, 2),
    rotation = 0,
    debug = false,
    options = {
        {
            name = 'police_bossmenu',
            icon = 'fas fa-briefcase',
            label = 'Open Police Boss Menu',
            canInteract = function(entity, distance, coords, name)
                return HasBossAccess() and PlayerData.job.name == 'police'
            end,
            onSelect = function()
                OpenBossMenu()
            end
        }
    }
})

-- Ambulance/EMS Boss Menu
exports.ox_target:addBoxZone({
    coords = vector3(335.2, -594.3, 43.28), -- Pillbox Hospital
    size = vector3(2, 2, 2),
    rotation = 0,
    debug = false,
    options = {
        {
            name = 'ambulance_bossmenu',
            icon = 'fas fa-briefcase',
            label = 'Open EMS Boss Menu',
            canInteract = function(entity, distance, coords, name)
                return HasBossAccess() and PlayerData.job.name == 'ambulance'
            end,
            onSelect = function()
                OpenBossMenu()
            end
        }
    }
})

-- Mechanic Shop Boss Menu
exports.ox_target:addBoxZone({
    coords = vector3(-347.96, -135.36, 39.01), -- LS Customs
    size = vector3(2, 2, 2),
    rotation = 0,
    debug = false,
    options = {
        {
            name = 'mechanic_bossmenu',
            icon = 'fas fa-briefcase',
            label = 'Open Mechanic Boss Menu',
            canInteract = function(entity, distance, coords, name)
                return HasBossAccess() and PlayerData.job.name == 'mechanic'
            end,
            onSelect = function()
                OpenBossMenu()
            end
        }
    }
})

-- Generic Boss Menu (for any job at city hall)
exports.ox_target:addBoxZone({
    coords = vector3(-265.0, -963.6, 31.22), -- City Hall
    size = vector3(2, 2, 2),
    rotation = 0,
    debug = false,
    options = {
        {
            name = 'generic_bossmenu',
            icon = 'fas fa-briefcase',
            label = 'Open Boss Menu',
            canInteract = function(entity, distance, coords, name)
                return HasBossAccess()
            end,
            onSelect = function()
                OpenBossMenu()
            end
        }
    }
})

-- Alternative: Use existing objects as targets instead of zones
-- Example: Office desk or computer

exports.ox_target:addModel({
    model = 'prop_laptop_01a', -- Target laptop props
    options = {
        {
            name = 'laptop_bossmenu',
            icon = 'fas fa-laptop',
            label = 'Access Boss Menu',
            canInteract = function(entity, distance, coords, name)
                return HasBossAccess()
            end,
            onSelect = function()
                OpenBossMenu()
            end
        }
    }
})

-- Note: Choose ONE method - either zones or models, don't use both for the same functionality