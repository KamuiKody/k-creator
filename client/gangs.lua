QBCore = exports['qb-core']:GetCoreObject()
local approved = false
local dialog = nil
local ranks = {}
local rank = 0

local function createRanks(num)
    if num > 0 then
        ranks[rank] = exports['qb-input']:ShowInput({
            header = "Rank ["..grade.."] Creation",
            submitText = "Submit Item",
            inputs = {
                {
                    text = "Rank Label (as displayed)",
                    name = "label",
                    type = "text",
                    isRequired = true,
                },
                {
                    text = "Extra Options",
                    name = "checks",
                    type = "checkbox",
                    options = {
                        { value = "isboss", text = "Is Boss?"}
                    }
                },
            }
        })
        rank = rank + 1
        createRanks(num-1)
    else
        TriggerServerEvent('k-creator:createGang',dialog,ranks)
        dialog = nil
        ranks = {}
    end
end

local function CreateGang()
    dialog = exports['qb-input']:ShowInput({
        header = "Job Creation",
        submitText = "Submit Item",
        inputs = {
            {
                text = "File Name",
                name = "password",
                type = "text",
                isRequired = true,
                default = 'gangs.lua'
            },
            {
                text = "Gang Name (lowercase)",
                name = "name",
                type = "text",
                isRequired = true,
            },
            {
                text = "Gang Label (as displayed)",
                name = "label",
                type = "text",
                isRequired = true,
            },
            {
                text = "Starting Society $",
                name = "money",
                type = "number",
                isRequired = true,
            },
            {
                text = "How Many Ranks",
                name = "ranks",
                type = "number",
                isRequired = true,
                default = 1
            }
        }
    })
    grade = 0
    createRanks(tonumber(dialog['ranks']))
end

RegisterNetEvent('k-creator:gang', function()
    CreateGang()
end)