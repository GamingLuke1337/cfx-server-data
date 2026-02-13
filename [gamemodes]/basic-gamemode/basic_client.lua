AddEventHandler('onClientMapStart', function()
    CreateThread(function()
        while GetResourceState('spawnmanager') ~= 'started' do
            Wait(0)
        end

        exports.spawnmanager:setAutoSpawn(true)
        exports.spawnmanager:forceRespawn()
    end)
end)
