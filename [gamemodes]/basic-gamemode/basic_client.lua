AddEventHandler('onClientMapStart', function()
    CreateThread(function()
        -- Wait a moment for safety
        Wait(500)

        exports.spawnmanager:setAutoSpawn(true)
        exports.spawnmanager:forceRespawn()
    end)
end)
