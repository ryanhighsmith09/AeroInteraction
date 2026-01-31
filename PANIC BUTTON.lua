RegisterNetEvent('leo:panic', function()
    local src = source
    TriggerClientEvent('leo:panicAlert', -1, src)
end)
