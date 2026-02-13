local currentHosting = nil
local hostReleaseCallbacks = {}

RegisterNetEvent('hostedSession:acquire', function()
    local src = source

    if currentHosting then
        TriggerClientEvent('sessionHostResult', src, 'wait')

        hostReleaseCallbacks[#hostReleaseCallbacks + 1] = function()
            TriggerClientEvent('sessionHostResult', src, 'free')
        end

        return
    end

    -- Optional advisory conflict check
    local hostId = GetHostId and GetHostId() or nil
    if hostId and GetPlayerLastMsg(hostId) < 1000 then
        TriggerClientEvent('sessionHostResult', src, 'conflict')
        return
    end

    currentHosting = src
    hostReleaseCallbacks = {}

    TriggerClientEvent('sessionHostResult', src, 'go')

    SetTimeout(5000, function()
        if currentHosting ~= src then
            return -- lock was released or taken by someone else
        end

        currentHosting = nil

        for _, cb in ipairs(hostReleaseCallbacks) do cb() end
        hostReleaseCallbacks = {}
    end)
end)

RegisterNetEvent('hostedSession:release', function()
    local src = source

    if currentHosting ~= src then
        -- this is either a bug or a malicious client
        print(('hostedSession:release mismatch: current=%s src=%s'):format(tostring(currentHosting), tostring(src)))
        -- DropPlayer(src, 'Invalid host release') -- if you want strict enforcement
        return
    end

    currentHosting = nil
    for _, cb in ipairs(hostReleaseCallbacks) do cb() end
    hostReleaseCallbacks = {}
end)

EnableEnhancedHostSupport(true)
