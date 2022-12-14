QBCore = exports['qb-core']:GetCoreObject()
local approved = false
local dialog = nil
local grades = {}
local grade = 0

local function createGrades(num)
    if num > 0 then
        grades[grade] = exports['qb-input']:ShowInput({
            header = "Grade ["..grade.."] Creation",
            submitText = "Submit Item",
            inputs = {
                {
                    text = "Grade Label (as displayed)",
                    name = "label",
                    type = "text",
                    isRequired = true,
                },
                {
                    text = "Payment",
                    name = "pay",
                    type = "number",
                    isRequired = true,
                    default = 50
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
        grade = grade + 1
        createGrades(num-1)
    else
        TriggerServerEvent('k-creator:createJob',dialog,grades)
        dialog = nil
        grades = {}
    end
end

local function CreateJob()
    dialog = exports['qb-input']:ShowInput({
        header = "Job Creation",
        submitText = "Submit Item",
        inputs = {
            {
                text = "File Name",
                name = "password",
                type = "text",
                isRequired = true,
                default = 'jobs.lua'
            },
            {
                text = "Job Name (lowercase)",
                name = "name",
                type = "text",
                isRequired = true,
            },
            {
                text = "Job Type (lowercase)",
                name = "type",
                type = "text",
                isRequired = true,
            },
            {
                text = "Job Label (as displayed)",
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
                text = "Extra Options",
                name = "checks",
                type = "checkbox",
                options = {
                    { value = "duty", text = "Default Duty", checked = true},
                    { value = "offduty", text = "Off Duty Pay"},
                    { value = "cityhall", text = "In City Hall"}
                }
            },
            {
                text = "How Many Grades",
                name = "grades",
                type = "number",
                isRequired = true,
                default = 1
            }
        }
    })
    grade = 0
    createGrades(tonumber(dialog['grades']))
end

RegisterNetEvent('k-creator:job', function()
    CreateJob()
end)