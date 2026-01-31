local isCuffed = false
local escorter = nil

-- Keybind (F6)
RegisterCommand('leomenu', function()
    TriggerServerEvent('leo:checkPermission')
end)
RegisterKeyMapping('leomenu', 'LEO Interaction Menu', 'keyboard', 'F6')

RegisterNetEvent('leo:openMenu', function()
    local elements = {
        {label = 'Cuff / Uncuff', value = 'cuff'},
        {label = 'Escort', value = 'escort'},
        {label = 'Put in Vehicle', value = 'putveh'},
        {label = 'Remove from Vehicle', value = 'outveh'},
    }

    SetNuiFocus(true, true)

    -- Simple menu using keyboard numbers
    print('LEO MENU:')
    for i,v in ipairs(elements) do
        print(i .. '. ' .. v.label)
    end
end)

RegisterNetEvent('leo:doAction', function(action, officer)
    local ped = PlayerPedId()

    if action == 'cuff' then
        isCuffed = not isCuffed
        SetEnableHandcuffs(ped, isCuffed)
        FreezeEntityPosition(ped, isCuffed)

    elseif action == 'escort' then
        if escorter then
            DetachEntity(ped, true, false)
            escorter = nil
        else
            escorter = officer
            AttachEntityToEntity(
                ped,
                GetPlayerPed(GetPlayerFromServerId(officer)),
                11816,
                0.54, 0.54, 0.0,
                0.0, 0.0, 0.0,
                false, false, false, false, 2, true
            )
        end

    elseif action == 'putveh' then
        local veh = GetVehiclePedIsNear(ped)
        if veh ~= 0 then
            TaskWarpPedIntoVehicle(ped, veh, 2)
        end

    elseif action == 'outveh' then
        TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped, false), 16)
    end
end)

RegisterNetEvent('leo:notify', function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(false, false)
end)

function GetVehiclePedIsNear(ped)
    local coords = GetEntityCoords(ped)
    return GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
end
