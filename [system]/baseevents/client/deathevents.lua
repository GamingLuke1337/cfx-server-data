CreateThread(function()
    local isDead = false
    local deathHandled = false
    local diedAt = nil

    while true do
        Wait(0)

        local player = PlayerId()
        if not NetworkIsPlayerActive(player) then
            goto continue
        end

        local ped = PlayerPedId()

        if IsPedFatallyInjured(ped) then
            if not isDead then
                -- transition: alive -> dead
                isDead = true
                deathHandled = false
                diedAt = GetGameTimer()

                local coords = GetEntityCoords(ped)

                -- "wasted" (once per death)
                TriggerEvent('baseevents:onPlayerWasted', { coords.x, coords.y, coords.z })
                TriggerServerEvent('baseevents:onPlayerWasted', { coords.x, coords.y, coords.z })

                -- killer info
                local killer, killerweapon = NetworkGetEntityKillerOfPlayer(player)
                if killer == 0 then killer = -1 end

                local killerentitytype = (killer ~= -1) and GetEntityType(killer) or 0
                local killertype = -1
                local killerinvehicle = false
                local killervehiclename = ''
                local killervehicleseat = 0

                if killerentitytype == 1 then
                    killertype = GetPedType(killer)

                    if IsPedInAnyVehicle(killer, false) then
                        killerinvehicle = true
                        local veh = GetVehiclePedIsUsing(killer)
                        if veh ~= 0 and DoesEntityExist(veh) then
                            killervehiclename = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
                            killervehicleseat = GetPedVehicleSeat(killer)
                        end
                    end
                end

                local killerid = -1
                if killer ~= ped and killer ~= -1 and killerentitytype == 1 then
                    local maybePlayer = GetPlayerByEntityID(killer)
                    if maybePlayer ~= nil and NetworkIsPlayerActive(maybePlayer) then
                        killerid = GetPlayerServerId(maybePlayer)
                    end
                end

                -- die vs killed
                if killer == ped or killer == -1 or killerid == -1 then
                    TriggerEvent('baseevents:onPlayerDied', killertype, { coords.x, coords.y, coords.z })
                    TriggerServerEvent('baseevents:onPlayerDied', killertype, { coords.x, coords.y, coords.z })
                else
                    local payload = {
                        killertype   = killertype,
                        weaponhash   = killerweapon,
                        killerinveh  = killerinvehicle,
                        killervehseat= killervehicleseat,
                        killervehname= killervehiclename,
                        killerpos    = { coords.x, coords.y, coords.z },
                    }
                    TriggerEvent('baseevents:onPlayerKilled', killerid, payload)
                    TriggerServerEvent('baseevents:onPlayerKilled', killerid, payload)
                end

                deathHandled = true
            end
        else
            -- alive (reset state)
            if isDead then
                isDead = false
                deathHandled = false
                diedAt = nil
            end
        end

        ::continue::
    end
end)

function GetPlayerByEntityID(entityPed)
    for _, player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == entityPed then
            return player
        end
    end
    return nil
end
