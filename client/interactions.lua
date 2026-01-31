RegisterNetEvent('leo:interaction', function(action)
    local target, dist = GetClosestPlayer()
    if not target or dist > Config.MaxDistance then return end

    if Config.UseLOS and not HasEntityClearLosToEntity(
        PlayerPedId(),
        GetPlayerPed(target),
        17
    ) then return end

    TriggerServerEvent('leo:action', action, GetPlayerServerId(target))
end)
