-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

fx_version 'cerulean'
game 'gta5'

version '2.0.1'
author 'Cfx.re <root@cfx.re>'
description 'A basic resource for displaying player names.'
repository 'https://github.com/bitpredator/cfx-server-data'

shared_script 'api.lua'

client_script 'client.lua'
server_script 'server.lua'

files {
    'templates/*.lua'
}