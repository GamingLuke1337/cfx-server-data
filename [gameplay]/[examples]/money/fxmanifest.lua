-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

<<<<<<< Updated upstream
version("2.0.1")
description("An example money system using KVS.")
repository("https://github.com/bitpredator/cfx-server-data")
author("Cfx.re <root@cfx.re>")
=======
fx_version 'cerulean'
game 'gta5'
>>>>>>> Stashed changes

version '2.0.1'
author 'Cfx.re <root@cfx.re>'
description 'An example money system using KVS.'
repository 'https://github.com/bitpredator/cfx-server-data'

client_script 'client.lua'
server_script 'server.lua'

dependency 'cfx.re/playerData.v1alpha1'