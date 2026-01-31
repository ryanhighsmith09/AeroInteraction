RegisterNetEvent('leo:requestMenu', function()
    local src = source

    if IsPlayerAceAllowed(src, 'leomenu.use') then
        TriggerClientEvent('leo:openMenu', src)
    else
        TriggerClientEvent('leo:notify', src, 'You are not law enforcement.')
    end
end)

RegisterNetEvent('leo:action', function(action, target)
    local src = source
    if not IsPlayerAceAllowed(src, 'leomenu.use') then return end

    TriggerClientEvent('leo:performAction', target, action, src)
end)
