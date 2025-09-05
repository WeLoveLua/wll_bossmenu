local ESX = exports["es_extended"]:getSharedObject()
local PlayerData = {}
local isMenuOpen = false

-- Initialize ESX
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

-- Function to check if player has boss access
local function HasBossAccess()
    if not PlayerData.job then return false end
    
    -- Check if job is restricted
    if #Config.BossMenu.jobs > 0 then
        local hasJob = false
        for _, job in ipairs(Config.BossMenu.jobs) do
            if job == PlayerData.job.name then
                hasJob = true
                break
            end
        end
        if not hasJob then return false end
    end
    
    -- Check grade access
    for _, grade in ipairs(Config.BossMenu.grades) do
        if PlayerData.job.grade >= grade then
            return true
        end
    end
    
    return false
end

-- Function to open boss menu
local function OpenBossMenu()
    if not HasBossAccess() then
        lib.notify({
            title = 'Access Denied',
            description = 'You do not have permission to access the boss menu',
            type = 'error',
            position = Config.Notifications.position,
            duration = Config.Notifications.duration
        })
        return
    end
    
    if isMenuOpen then return end
    
    isMenuOpen = true
    SetNuiFocus(true, true)
    
    -- Send initial data to UI
    ESX.TriggerServerCallback('wll_bossmenu:getMenuData', function(data)
        SendNUIMessage({
            action = 'openMenu',
            data = data
        })
    end)
end

-- Function to close boss menu
local function CloseBossMenu()
    if not isMenuOpen then return end
    
    isMenuOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'closeMenu'
    })
end

-- NUI Callbacks
RegisterNUICallback('close', function(data, cb)
    CloseBossMenu()
    cb('ok')
end)

RegisterNUICallback('getEmployees', function(data, cb)
    ESX.TriggerServerCallback('wll_bossmenu:getEmployees', function(employees)
        cb(employees)
    end)
end)

RegisterNUICallback('hirePlayer', function(data, cb)
    ESX.TriggerServerCallback('wll_bossmenu:hirePlayer', function(success, message)
        cb({success = success, message = message})
        if success then
            lib.notify({
                title = 'Success',
                description = message,
                type = 'success',
                position = Config.Notifications.position,
                duration = Config.Notifications.duration
            })
        else
            lib.notify({
                title = 'Error',
                description = message,
                type = 'error',
                position = Config.Notifications.position,
                duration = Config.Notifications.duration
            })
        end
    end, data.playerId, data.grade)
end)

RegisterNUICallback('firePlayer', function(data, cb)
    ESX.TriggerServerCallback('wll_bossmenu:firePlayer', function(success, message)
        cb({success = success, message = message})
        if success then
            lib.notify({
                title = 'Success',
                description = message,
                type = 'success',
                position = Config.Notifications.position,
                duration = Config.Notifications.duration
            })
        else
            lib.notify({
                title = 'Error',
                description = message,
                type = 'error',
                position = Config.Notifications.position,
                duration = Config.Notifications.duration
            })
        end
    end, data.playerId)
end)

RegisterNUICallback('promotePlayer', function(data, cb)
    ESX.TriggerServerCallback('wll_bossmenu:promotePlayer', function(success, message)
        cb({success = success, message = message})
        if success then
            lib.notify({
                title = 'Success',
                description = message,
                type = 'success',
                position = Config.Notifications.position,
                duration = Config.Notifications.duration
            })
        else
            lib.notify({
                title = 'Error',
                description = message,
                type = 'error',
                position = Config.Notifications.position,
                duration = Config.Notifications.duration
            })
        end
    end, data.playerId, data.newGrade)
end)

RegisterNUICallback('withdrawMoney', function(data, cb)
    ESX.TriggerServerCallback('wll_bossmenu:withdrawMoney', function(success, message)
        cb({success = success, message = message})
        if success then
            lib.notify({
                title = 'Success',
                description = message,
                type = 'success',
                position = Config.Notifications.position,
                duration = Config.Notifications.duration
            })
        else
            lib.notify({
                title = 'Error',
                description = message,
                type = 'error',
                position = Config.Notifications.position,
                duration = Config.Notifications.duration
            })
        end
    end, data.amount)
end)

RegisterNUICallback('depositMoney', function(data, cb)
    ESX.TriggerServerCallback('wll_bossmenu:depositMoney', function(success, message)
        cb({success = success, message = message})
        if success then
            lib.notify({
                title = 'Success',
                description = message,
                type = 'success',
                position = Config.Notifications.position,
                duration = Config.Notifications.duration
            })
        else
            lib.notify({
                title = 'Error',
                description = message,
                type = 'error',
                position = Config.Notifications.position,
                duration = Config.Notifications.duration
            })
        end
    end, data.amount)
end)

-- Keybind support (if enabled)
if Config.UI.useKeybind then
    RegisterCommand('bossmenu', function()
        OpenBossMenu()
    end)
    
    RegisterKeyMapping('bossmenu', 'Open Boss Menu', 'keyboard', Config.UI.keybind)
end

-- Exports
exports('OpenBossMenu', OpenBossMenu)
exports('CloseBossMenu', CloseBossMenu)
exports('HasBossAccess', HasBossAccess)

-- ox_target integration
CreateThread(function()
    if Config.Target.system == 'ox_target' then
        -- Example target zones (you can add specific locations or objects)
        exports.ox_target:addBoxZone({
            coords = vector3(-541.0, -216.0, 37.65), -- Example coordinates (change as needed)
            size = vector3(2, 2, 2),
            rotation = 0,
            debug = false,
            options = {
                {
                    name = 'wll_bossmenu',
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
    end
end)
