local ESX = exports["es_extended"]:getSharedObject()

-- Get menu data callback
ESX.RegisterServerCallback('wll_bossmenu:getMenuData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(false)
        return
    end
    
    local job = xPlayer.getJob()
    if not job then
        cb(false)
        return
    end
    
    -- Get job account balance
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job.name, function(account)
        local society = account or {money = 0}
        
        -- Get employees
        MySQL.Async.fetchAll('SELECT * FROM users WHERE job = @job', {
            ['@job'] = job.name
        }, function(employees)
            
            local employeeData = {}
            for _, employee in ipairs(employees) do
                table.insert(employeeData, {
                    identifier = employee.identifier,
                    name = employee.firstname .. ' ' .. employee.lastname,
                    grade = employee.job_grade,
                    gradeName = ESX.Jobs[job.name].grades[tostring(employee.job_grade)].label or 'Unknown'
                })
            end
            
            cb({
                job = {
                    name = job.name,
                    label = job.label,
                    grade = job.grade,
                    gradeName = job.grade_label
                },
                society = {
                    money = society.money or 0
                },
                employees = employeeData,
                grades = ESX.Jobs[job.name] and ESX.Jobs[job.name].grades or {}
            })
        end)
    end)
end)

-- Get employees callback
ESX.RegisterServerCallback('wll_bossmenu:getEmployees', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb({})
        return
    end
    
    local job = xPlayer.getJob()
    
    MySQL.Async.fetchAll('SELECT * FROM users WHERE job = @job', {
        ['@job'] = job.name
    }, function(result)
        local employees = {}
        for _, employee in ipairs(result) do
            table.insert(employees, {
                identifier = employee.identifier,
                name = employee.firstname .. ' ' .. employee.lastname,
                grade = employee.job_grade,
                gradeName = ESX.Jobs[job.name].grades[tostring(employee.job_grade)].label or 'Unknown'
            })
        end
        cb(employees)
    end)
end)

-- Hire player callback
ESX.RegisterServerCallback('wll_bossmenu:hirePlayer', function(source, cb, playerId, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(playerId)
    
    if not xPlayer or not xTarget then
        cb(false, 'Player not found')
        return
    end
    
    local job = xPlayer.getJob()
    local targetJob = xTarget.getJob()
    
    -- Check permissions
    if job.grade < 2 then
        cb(false, 'Insufficient permissions')
        return
    end
    
    -- Check if player is already in organization
    if targetJob.name == job.name then
        cb(false, 'Player is already in your organization')
        return
    end
    
    -- Set the job
    xTarget.setJob(job.name, grade or 0)
    
    cb(true, 'Player hired successfully')
    
    -- Log the action
    TriggerClientEvent('esx:showNotification', xTarget.source, 'You have been hired by ' .. job.label)
end)

-- Fire player callback
ESX.RegisterServerCallback('wll_bossmenu:firePlayer', function(source, cb, targetIdentifier)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(false, 'Invalid source')
        return
    end
    
    local job = xPlayer.getJob()
    
    -- Check permissions
    if job.grade < 2 then
        cb(false, 'Insufficient permissions')
        return
    end
    
    -- Find target player
    local xTarget = ESX.GetPlayerFromIdentifier(targetIdentifier)
    
    if xTarget then
        -- Player is online
        local targetJob = xTarget.getJob()
        
        if targetJob.name ~= job.name then
            cb(false, 'Player is not in your organization')
            return
        end
        
        if targetJob.grade >= job.grade then
            cb(false, 'Cannot fire player with equal or higher rank')
            return
        end
        
        xTarget.setJob('unemployed', 0)
        TriggerClientEvent('esx:showNotification', xTarget.source, 'You have been fired from ' .. job.label)
        
        cb(true, 'Player fired successfully')
    else
        -- Player is offline, update database
        MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @grade WHERE identifier = @identifier', {
            ['@job'] = 'unemployed',
            ['@grade'] = 0,
            ['@identifier'] = targetIdentifier
        }, function(affectedRows)
            if affectedRows > 0 then
                cb(true, 'Player fired successfully')
            else
                cb(false, 'Failed to fire player')
            end
        end)
    end
end)

-- Promote player callback
ESX.RegisterServerCallback('wll_bossmenu:promotePlayer', function(source, cb, targetIdentifier, newGrade)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(false, 'Invalid source')
        return
    end
    
    local job = xPlayer.getJob()
    
    -- Check permissions
    if job.grade < 2 then
        cb(false, 'Insufficient permissions')
        return
    end
    
    if newGrade >= job.grade then
        cb(false, 'Cannot promote to equal or higher rank than yours')
        return
    end
    
    -- Find target player
    local xTarget = ESX.GetPlayerFromIdentifier(targetIdentifier)
    
    if xTarget then
        -- Player is online
        local targetJob = xTarget.getJob()
        
        if targetJob.name ~= job.name then
            cb(false, 'Player is not in your organization')
            return
        end
        
        xTarget.setJob(job.name, newGrade)
        TriggerClientEvent('esx:showNotification', xTarget.source, 'You have been promoted in ' .. job.label)
        
        cb(true, 'Player promoted successfully')
    else
        -- Player is offline, update database
        MySQL.Async.execute('UPDATE users SET job_grade = @grade WHERE identifier = @identifier', {
            ['@grade'] = newGrade,
            ['@identifier'] = targetIdentifier
        }, function(affectedRows)
            if affectedRows > 0 then
                cb(true, 'Player promoted successfully')
            else
                cb(false, 'Failed to promote player')
            end
        end)
    end
end)

-- Withdraw money callback
ESX.RegisterServerCallback('wll_bossmenu:withdrawMoney', function(source, cb, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(false, 'Invalid source')
        return
    end
    
    local job = xPlayer.getJob()
    
    -- Check permissions
    if job.grade < 2 then
        cb(false, 'Insufficient permissions')
        return
    end
    
    -- Validate amount
    if amount <= 0 or amount > Config.Finance.maxWithdraw then
        cb(false, 'Invalid amount')
        return
    end
    
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job.name, function(account)
        if account.money >= amount then
            account.removeMoney(amount)
            xPlayer.addMoney(amount)
            cb(true, 'Successfully withdrew $' .. ESX.Math.GroupDigits(amount))
        else
            cb(false, 'Insufficient funds in organization account')
        end
    end)
end)

-- Deposit money callback
ESX.RegisterServerCallback('wll_bossmenu:depositMoney', function(source, cb, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(false, 'Invalid source')
        return
    end
    
    local job = xPlayer.getJob()
    
    -- Check permissions
    if job.grade < 1 then
        cb(false, 'Insufficient permissions')
        return
    end
    
    -- Validate amount
    if amount <= 0 or amount > Config.Finance.maxDeposit then
        cb(false, 'Invalid amount')
        return
    end
    
    if xPlayer.getMoney() >= amount then
        xPlayer.removeMoney(amount)
        
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job.name, function(account)
            account.addMoney(amount)
            cb(true, 'Successfully deposited $' .. ESX.Math.GroupDigits(amount))
        end)
    else
        cb(false, 'Insufficient personal funds')
    end
end)

-- Events
RegisterNetEvent('wll_bossmenu:refreshMenu')
AddEventHandler('wll_bossmenu:refreshMenu', function()
    local source = source
    TriggerClientEvent('wll_bossmenu:refreshData', source)
end)
