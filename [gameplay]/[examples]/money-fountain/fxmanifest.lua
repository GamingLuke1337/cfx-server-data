-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

fx_version 'cerulean'
game 'gta5'

version '2.0.1'
author 'Cfx.re <root@cfx.re>'
description 'An example money system client containing a money fountain.'
repository 'https://github.com/bitpredator/cfx-server-data'

shared_script 'shared/main.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'

dependency 'money'
