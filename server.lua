RegisterNetEvent('leo:checkPermission', function()
    local src = source
    if IsPlayerAceAllowed(src, 'leomenu.use') then
        TriggerClientEvent('leo:openMenu', src)
    else
        TriggerClientEvent('leo:notify', src, 'You are not law enforcement.')
    end
end)

RegisterNetEvent('leo:syncAction', function(action, target)
    TriggerClientEvent('leo:doAction', target, action, source)
end)
