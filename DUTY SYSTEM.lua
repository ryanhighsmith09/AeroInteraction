-- server
local onDuty = {}

RegisterNetEvent('leo:toggleDuty', function()
    local src = source
    onDuty[src] = not onDuty[src]
    TriggerClientEvent('leo:dutyStatus', src, onDuty[src])
end)
