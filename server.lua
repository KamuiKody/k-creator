local QBCore = exports['qb-core']:GetCoreObject()
local path = GetResourcePath('k-ezjob')
local itemsPath = path:gsub('//', '/')..'/shared/items/'
local jobsPath = path:gsub('//', '/')..'/shared/jobs/'
local gangsPath = path:gsub('//', '/')..'/shared/gangs/'

RegisterNetEvent('k-creator:createJob', function(job, grades)
    local src = source
    if QBCore.Functions.GetIdentifier(src, Config.IdType) == Config.Whitelist then
        local file = io.open(jobsPath..job['password'], 'a+')
        local label = "\n\nImports.Jobs['"..job['name'].."'] = { \r    cityhall = "..job['cityhall']..", \r    startingCash = "..tonumber(job['money'])..", \r    label = '"..job['label'].."', \r    type = '"..job['type'].."', \r    defaultDuty = "..job["duty"]..", \r    offDutyPay = "..job["offduty"]..", \r    grades = { "
        local stage = 0
        for i = 1, job['grades'] do
            label = label.."\r        ["..stage.."] = { \r            isboss = "..grades[stage]['isboss'].." ,\r            name = '"..grades[stage]['label'].."', \r            payment = "..tonumber(grades[stage]['pay']).." \r        },"
            stage = stage + 1
        end
        label = label.."\r    } \r}"
        file:write(label)
        file:close()
        TriggerClientEvent('QBCore:Notify', src, 'Job Created : '..job['label'])
        if Config.DontUse then
            TriggerEvent('qb-log:server:CreateLog', src, Config.Log, 'Test Webhook', 'default', label..' added by '..QBCore.Functions.GetIdentifier(src, Config.IdType) )
        else
            TriggerEvent('qb-log:server:CreateLog', Config.Log, 'Test Webhook', 'default', label..' added by '..QBCore.Functions.GetIdentifier(src, Config.IdType) )
        end
        if Config.AddNow then
            TriggerEvent('k-ezjob:ImportUpdate')
            TriggerClientEvent('k-ezjob:Client:ImportUpdate', -1)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You dont have access sorry')
    end
end)

RegisterNetEvent('k-creator:createGang', function(gang, ranks)
    local src = source
    if QBCore.Functions.GetIdentifier(src, Config.IdType) == Config.Whitelist then
        local file = io.open(gangsPath..gang['password'], 'a+')
        local label = "\n\nImports.Gangs['"..gang['name'].."'] = { \r    startingCash = "..tonumber(gang['money'])..", \r    label = '"..gang['label'].."', \r    grades = { "
        local stage = 0
        for i = 1, gang['ranks'] do
            label = label.."\r        ["..stage.."] = { \r            isboss = "..ranks[stage]['isboss']..", \r            name = '"..ranks[stage]['label'].."', \r        },"
            stage = stage + 1
        end
        label = label.."\r    } \r}"
        file:write(label)
        file:close()
        TriggerClientEvent('QBCore:Notify', src, 'Gang Created : '..gang['label'])
        if Config.DontUse then
            TriggerEvent('qb-log:server:CreateLog', src, Config.Log, 'Test Webhook', 'default', label..' added by '..QBCore.Functions.GetIdentifier(src, Config.IdType) )
        else
            TriggerEvent('qb-log:server:CreateLog', Config.Log, 'Test Webhook', 'default', label..' added by '..QBCore.Functions.GetIdentifier(src, Config.IdType) )
        end
        if Config.AddNow then
            TriggerEvent('k-ezjob:ImportUpdate')
            TriggerClientEvent('k-ezjob:Client:ImportUpdate', -1)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You dont have access sorry')
    end
end)

RegisterNetEvent('k-creator:createItem', function(data)
    local src = source
    if not data or not next(data) then return end
    if QBCore.Functions.GetIdentifier(src, Config.IdType) == Config.Whitelist then
        local file = io.open(itemsPath..data['password'], 'a+')
        local label = "\n\nImports.Items['"..data.name.."'] = {\r    ['name'] = '"..data.name.."', \r    ['label'] = '"..data.label.."', \r    ['weight'] = "..data.weight..", \r    ['type'] = 'item', \r    ['image'] = '"..data.image.."', \r    ['hunger'] = "..tonumber(data['food'])..", \r    ['thirst'] = "..tonumber(data['water'])..", \r    ['alcohol'] = "..tonumber(data['alcohol'])..", \r    ['unique'] = "..data['unique']..", \r    ['useable'] = "..data['useable']..", \r    ['shouldClose'] = "..data['shouldclose']..", \r    ['combinable'] = nil, \r    ['description'] = '"..data['description'].."' \r}"
        file:write(label)
        file:close()
        TriggerClientEvent('QBCore:Notify', src, 'Item Created : '..data.label)
        if Config.DontUse then
            TriggerEvent('qb-log:server:CreateLog', src, Config.Log, 'Test Webhook', 'default', label..' added by '..QBCore.Functions.GetIdentifier(src, Config.IdType) )
        else
            TriggerEvent('qb-log:server:CreateLog', Config.Log, 'Test Webhook', 'default', label..' added by '..QBCore.Functions.GetIdentifier(src, Config.IdType) )
        end
        if Config.AddNow then
            --exports['qb-core']:AddItem(data.name,{['name'] = data.name,['label'] = data.label,['weight'] = data.weight,['type'] = 'item',['image'] = data.image,['hunger'] = hunger,['thirst'] = thirst,['alcohol'] = alcohol,['unique'] = data['unique'],['useable'] = data['useable'],['shouldClose'] = data['shouldclose'],['combinable'] = nil,['description'] = data['description']})
            --TriggerClientEvent('QBCore:Client:UpdateObject', -1)
            TriggerEvent('k-ezjob:ImportUpdate')
            TriggerClientEvent('k-ezjob:Client:ImportUpdate', -1)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You dont have access sorry')
    end
end)

QBCore.Commands.Add(Config.Item, 'new item', {}, false, function(source)
    local src = source
    if Config.GetId then
        print(QBCore.Functions.GetIdentifier(src, Config.IdType))
    end
    if QBCore.Functions.GetIdentifier(src, Config.IdType) == Config.Whitelist then
        TriggerClientEvent('k-creator:create', src)
    end
end, 'god')

QBCore.Commands.Add(Config.Job, 'new job', {}, false, function(source)
    local src = source
    if Config.GetId then
        print(QBCore.Functions.GetIdentifier(src, Config.IdType))
    end
    if QBCore.Functions.GetIdentifier(src, Config.IdType) == Config.Whitelist then
        TriggerClientEvent('k-creator:job', src)
    end
end, 'god')

QBCore.Commands.Add(Config.Gang, 'new gang', {}, false, function(source)
    local src = source
    if Config.GetId then
        print(QBCore.Functions.GetIdentifier(src, Config.IdType))
    end
    if QBCore.Functions.GetIdentifier(src, Config.IdType) == Config.Whitelist then
        TriggerClientEvent('k-creator:gang', src)
    end
end, 'god')
