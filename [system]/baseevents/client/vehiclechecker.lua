local isEnteringVehicle = false
local isInVehicle = false
local currentVehicle = 0
local currentSeat = -2

CreateThread(function()
    while true do
        local ped = PlayerPedId()

        if not isInVehicle then
            local tryingVeh = GetVehiclePedIsTryingToEnter(ped)

            if tryingVeh ~= 0 and DoesEntityExist(tryingVeh) and not isEnteringVehicle then
                -- Entering Vehicle (start)
                isEnteringVehicle = true

                local model = GetEntityModel(tryingVeh)
                local vehicleName = GetDisplayNameFromVehicleModel(model)
                local netId = VehToNet(tryingVeh) -- may be 0 if not networked yet
                local seat = GetSeatPedIsTryingToEnter(ped)

                TriggerEvent('baseevents:enteringVehicle', tryingVeh, seat, model, vehicleName)
                TriggerServerEvent('baseevents:enteringVehicle', tryingVeh, seat, model, vehicleName, netId)

            elseif isEnteringVehicle then
                -- If we were entering, detect abort vs success
                if IsPedInAnyVehicle(ped, false) then
                    -- Entered Vehicle (success)
                    isEnteringVehicle = false
                    isInVehicle = true

                    currentVehicle = GetVehiclePedIsUsing(ped)
                    currentSeat = GetPedVehicleSeat(ped)

                    local model = GetEntityModel(currentVehicle)
                    local vehicleName = GetDisplayNameFromVehicleModel(model)
                    local netId = VehToNet(currentVehicle)

                    TriggerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, model, vehicleName)
                    TriggerServerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, model, vehicleName, netId)

                elseif (tryingVeh == 0 or not DoesEntityExist(tryingVeh)) and not IsPedInAnyVehicle(ped, true) then
                    -- Vehicle Entering Aborted
                    isEnteringVehicle = false

                    TriggerEvent('baseevents:enteringAborted')
                    TriggerServerEvent('baseevents:enteringAborted')
                end
            else
                -- Not entering yet; still detect if we are already in a vehicle (edge cases)
                if IsPedInAnyVehicle(ped, false) then
                    isInVehicle = true
                    currentVehicle = GetVehiclePedIsUsing(ped)
                    currentSeat = GetPedVehicleSeat(ped)

                    local model = GetEntityModel(currentVehicle)
                    local vehicleName = GetDisplayNameFromVehicleModel(model)
                    local netId = VehToNet(currentVehicle)

                    TriggerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, model, vehicleName)
                    TriggerServerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, model, vehicleName, netId)
                end
            end

        else
            -- isInVehicle == true
            if not IsPedInAnyVehicle(ped, false) then
                -- Exiting Vehicle
                if currentVehicle ~= 0 and DoesEntityExist(currentVehicle) then
                    local model = GetEntityModel(currentVehicle)
                    local vehicleName = GetDisplayNameFromVehicleModel(model)
                    local netId = VehToNet(currentVehicle)

                    TriggerEvent('baseevents:leftVehicle', currentVehicle, currentSeat, model, vehicleName)
                    TriggerServerEvent('baseevents:leftVehicle', currentVehicle, currentSeat, model, vehicleName, netId)
                else
                    -- Fallback: still notify without entity info if it vanished
                    TriggerEvent('baseevents:leftVehicle', 0, currentSeat, 0, 'UNKNOWN')
                    TriggerServerEvent('baseevents:leftVehicle', 0, currentSeat, 0, 'UNKNOWN', 0)
                end

                isInVehicle = false
                currentVehicle = 0
                currentSeat = -2
            end
        end

        Wait(100)
    end
end)

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle == 0 or not DoesEntityExist(vehicle) then
        return -2
    end

    for i = -2, GetVehicleMaxNumberOfPassengers(vehicle) do
        if GetPedInVehicleSeat(vehicle, i) == ped then
            return i
        end
    end

    return -2
end
