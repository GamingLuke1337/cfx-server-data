-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

<<<<<<< Updated upstream
version("2.0.1")
description("An example money system client containing a money fountain.")
repository("https://github.com/bitpredator/cfx-server-data")
author("Cfx.re <root@cfx.re>")
=======
fx_version 'cerulean'
game 'gta5'
>>>>>>> Stashed changes

version '2.0.1'
author 'Cfx.re <root@cfx.re>'
description 'An example money system client containing a money fountain.'
repository 'https://github.com/bitpredator/cfx-server-data'

shared_script "shared/main.lua"
client_script "client/main.lua"
server_script "server/main.lua"

dependencies {
    "mapmanager",
    "money"
}
