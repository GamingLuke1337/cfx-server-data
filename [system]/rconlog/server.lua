RconLog({ msgType = "serverStart", hostname = "lovely", maxplayers = 32 })

local names = {}

RegisterNetEvent("rlPlayerActivated", function()
    local src = source
    local ids = GetPlayerIdentifiers(src)
    local guid = (ids and ids[1]) or ""

    RconLog({
        msgType = "playerActivated",
        netID = src,
        name = GetPlayerName(src),
        guid = guid,
        ip = GetPlayerEndpoint(src) or ""
    })

    names[src] = { name = GetPlayerName(src), id = src }

    local host = GetHostId()
    if host and host > 0 then
        TriggerClientEvent("rlUpdateNames", host)
    end
end)

RegisterNetEvent("rlUpdateNamesResult", function(res)
    local host = GetHostId()
    if not host or host <= 0 or source ~= host then
        print("bad guy")
        return
    end

    if type(res) ~= "table" then return end

    for id, data in pairs(res) do
        id = tonumber(id)
        if id and type(data) == "table" and type(data.name) == "string" then
            local newName = data.name

            if not names[id] or names[id].name ~= newName then
                names[id] = { id = id, name = newName }
                RconLog({ msgType = "playerRenamed", netID = id, name = newName })
            end
        elseif id then
            names[id] = nil
        end
    end
end)

AddEventHandler("playerDropped", function()
    local src = source
    RconLog({ msgType = "playerDropped", netID = src, name = GetPlayerName(src) })
    names[src] = nil
end)

AddEventHandler("chatMessage", function(netID, name, message)
    if type(netID) ~= "number" then return end
    local ids = GetPlayerIdentifiers(netID)
    local guid = (ids and ids[1]) or ""
    RconLog({ msgType = "chatMessage", netID = netID, name = name, message = message, guid = guid })
end)

AddEventHandler("rconCommand", function(commandName, args)
    if commandName == "status" then
        for netid, data in pairs(names) do
            local ids = GetPlayerIdentifiers(netid)
            local guid = ids and ids[1]
            if guid and data then
                local ping = GetPlayerPing(netid)
                RconPrint(netid .. " " .. guid .. " " .. data.name .. " " .. (GetPlayerEndpoint(netid) or "") .. " " .. ping .. "\n")
            end
        end
        CancelEvent()

    elseif commandName:lower() == "clientkick" then
        local playerId = tonumber(table.remove(args, 1))
        if playerId then
            DropPlayer(playerId, table.concat(args, " "))
        end
        CancelEvent()

    elseif commandName:lower() == "tempbanclient" then
        local playerId = tonumber(table.remove(args, 1))
        if playerId then
            TempBanPlayer(playerId, table.concat(args, " "))
        end
        CancelEvent()
    end
end)

-- NOTE: DO NOT USE THIS METHOD FOR HANDLING COMMANDS
-- This resource has not been updated to use newer methods such as RegisterCommand.
AddEventHandler("rconCommand", function(commandName, args)
    if commandName == "status" then
        for netid, data in pairs(names) do
            local guid = GetPlayerIdentifiers(netid)
            if guid and guid[1] and data then
                local ping = GetPlayerPing(netid)
                RconPrint(netid .. " " .. guid[1] .. " " .. data.name .. " " .. GetPlayerEndpoint(netid) .. " " .. ping .. "\n")
            end
        end
        CancelEvent()
    elseif commandName:lower() == "clientkick" then
        local playerId = table.remove(args, 1)
        local msg = table.concat(args, " ")
        DropPlayer(playerId, msg)
        CancelEvent()
    elseif commandName:lower() == "tempbanclient" then
        local playerId = table.remove(args, 1)
        local msg = table.concat(args, " ")
        TempBanPlayer(playerId, msg)
        CancelEvent()
    end
end)