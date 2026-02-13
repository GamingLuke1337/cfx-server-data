AddEventHandler('onClientMapStart', function()
    CreateThread(function()
<<<<<<< Updated upstream
        -- Wait a moment for safety
=======
        -- Wait a moment, just to be on the safe side.
>>>>>>> Stashed changes
        Wait(500)

        exports.spawnmanager:setAutoSpawn(true)
        exports.spawnmanager:forceRespawn()
    end)
end)
