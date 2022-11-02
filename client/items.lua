QBCore = exports['qb-core']:GetCoreObject()
local approved = false

RegisterNetEvent('QBCore:Client:UpdateObject', function()
	QBCore = exports['qb-core']:GetCoreObject()
end)

local function CreateItem()
    print(1)
    local dialog = exports['qb-input']:ShowInput({
        header = "Item Creation",
        submitText = "Submit Item",
        inputs = {
            {
                text = "File Name",
                name = "password",
                type = "text",
                isRequired = true,
                default = 'items.lua'
            },
            {
                text = "Item Name (lowercase)",
                name = "name",
                type = "text",
                isRequired = true,
            },
            {
                text = "Item Label (as displayed)",
                name = "label",
                type = "text",
                isRequired = true,
            },
            {
                text = "Item Weight (in g)",
                name = "weight",
                type = "number",
                isRequired = true,
            },
            {
                text = "Item Image (image.png)",
                name = "image",
                type = "text",
                isRequired = true,
            },
            {
                text = "Extra Options",
                name = "checks",
                type = "checkbox",
                options = {
                    { value = "unique", text = "Unique (Prevent Stack)"},
                    { value = "useable", text = "Usable (Allow Use)"},
                    { value = "shouldclose", text = "Should Close on Use", checked = true }
                }
            },
            {
                text = "Item Description",
                name = "description",
                type = "text",
                isRequired = true,
            },
            {
                text = "Hunger Replenish",
                name = "food",
                type = "number",
                isRequired = true,
                default = 0
            },
            {
                text = "Thirst Replensih",
                name = "water",
                type = "number",
                isRequired = true,
                default = 0
            },
            {
                text = "Alcohol Effect(thirst)",
                name = "alcohol",
                type = "number",
                isRequired = true,
                default = 0
            }
        }
    })
    TriggerServerEvent('k-creator:createItem', dialog)
end

RegisterNetEvent('k-creator:create', function()
    CreateItem()
end)