-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

fx_version 'cerulean'
game 'gta5'

version '2.0.1'
author 'Cfx.re <root@cfx.re>'
description 'Adds basic events for developers to use in their scripts. Some third party resources may depend on this resource.'
repository 'https://github.com/bitpredator/cfx-server-data'

client_scripts {
    'client/deathevents.lua',
    'client/vehiclechecker.lua'
}

server_script 'server/main.lua'
