local isCuffed = false
local isEscorted = false
local escorter = nil

-- KEYBIND: M
RegisterCommand('leomenu', function()
    TriggerServerEvent('leo:requestMenu')
end)
RegisterKeyMapping('leomenu', 'LEO Interaction Menu', 'keyboard', 'M')

-- MENU (simple layered interaction logic)
RegisterNetEvent('leo:openMenu', function()
    local target, distance = GetClosestPlayer()
    if not target or distance > 3.0 then
        Notify('No player nearby')
        return
    end

    Notify(
        '[LEO MENU]\n' ..
        '1. Cuff / Uncuff\n' ..
        '2. Escort / Stop Escort\n' ..
        '3. Put in Vehicle\n' ..
        '4. Remove from Vehicle\n' ..
        'Use number keys'
    )

    CreateThread(function()
        while true do
            Wait(0)
            if IsControlJustPressed(0, 157) then SendAction('cuff', target) break end -- 1
            if IsControlJustPressed(0, 158) then SendAction('escort', target) break end -- 2
            if IsControlJustPressed(0, 160) then SendAction('putveh', target) break end -- 3
            if IsControlJustPressed(0, 164) then SendAction('outveh', target) break end -- 4
        end
    end)
end)

function SendAction(action, target)
    TriggerServerEvent('leo:action', action, GetPlayerServerId(target))
end

-- ACTION HANDLING
RegisterNetEvent('leo:performAction', function(action, officer)
    local ped = PlayerPedId()

    if action == 'cuff' then
        isCuffed = not isCuffed
        SetEnableHandcuffs(ped, isCuffed)
        FreezeEntityPosition(ped, isCuffed)

    elseif action == 'escort' then
        if isEscorted then
            DetachEntity(ped, true, false)
            isEscorted = false
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
            isEscorted = true
        end

    elseif action == 'putveh' then
        local veh = GetClosestVehicle(GetEntityCoords(ped), 5.0, 0, 71)
        if veh ~= 0 then
            TaskWarpPedIntoVehicle(ped, veh, 2)
        end

    elseif action == 'outveh' then
        TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped, false), 16)
    end
end)

-- HELPERS
function GetClosestPlayer()
    local players = GetActivePlayers()
    local closestPlayer, closestDistance = nil, -1
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    for _,player in ipairs(players) do
        if player ~= PlayerId() then
            local targetPed = GetPlayerPed(player)
            local targetCoords = GetEntityCoords(targetPed)
            local dist = #(coords - targetCoords)

            if closestDistance == -1 or dist < closestDistance then
                closestPlayer = player
                closestDistance = dist
            end
        end
    end
    return closestPlayer, closestDistance
end

function Notify(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(false, false)
end
