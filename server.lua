local QBCore = exports['qb-core']:GetCoreObject()
local path = GetResourcePath('k-ezjob')
local itemsPath = path:gsub('//', '/')..'/shared/items/'
local jobsPath = path:gsub('//', '/')..'/shared/jobs/'
local gangsPath = path:gsub('//', '/')..'/shared/gangs/'

RegisterNetEvent('k-creator:createItem', function(data)
    local src = source
    if QBCore.Functions.GetIdentifier(src, Config.IdType) == Config.Whitelist then
        local hunger = 'nil'
        local thirst = 'nil'
        local alcohol = 'nil'
        local file = io.open(itemsPath..data['password'], 'a+')
        if tonumber(data['food']) > 0 then
            hunger = tonumber(data['food'])
        end
        if tonumber(data['water']) > 0 then
            thirst = tonumber(data['water'])
        end
        if tonumber(data['alcohol']) > 0 then
            alcohol = tonumber(data['alcohol'])
        end
        local label = "\n\nImports.Items['"..data.name.."'] = {\r    ['name'] = '"..data.name.."', \r    ['label'] = '"..data.label.."', \r    ['weight'] = '"..data.weight.."', \r    ['type'] = 'item', \r    ['image'] = '"..data.image.."', \r    ['hunger'] = '"..hunger.."', \r    ['thirst'] = '"..thirst.."', \r    ['alcohol'] = '"..alcohol.."', \r    ['unique'] = '"..data['unique'].."', \r    ['useable'] = '"..data['useable'].."', \r    ['shouldClose'] = '"..data['shouldclose'].."', \r    ['combinable'] = nil, \r    ['description'] = '"..data['description'].."' \r}"
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
    print(Config.Whitelist )
    print(QBCore.Functions.GetIdentifier(src, Config.IdType))
    if QBCore.Functions.GetIdentifier(src, Config.IdType) == Config.Whitelist then
        TriggerClientEvent('k-creator:create', src)
    end
end, 'god')
