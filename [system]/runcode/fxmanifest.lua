-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

<<<<<<< Updated upstream
version("2.0.1")
author("Cfx.re <root@cfx.re>")
description(
"Allows server owners to execute arbitrary server-side or client-side JavaScript/Lua code. *Consider only using this on development servers.")
repository("https://github.com/bitpredator/cfx-server-data")
=======
fx_version 'cerulean'
game 'common'
>>>>>>> Stashed changes

version '2.0.1'
author 'Cfx.re <root@cfx.re>'
description 'Allows server owners to execute arbitrary server-side or client-side JavaScript/Lua code. *Consider only using this on development servers.'
repository 'https://github.com/bitpredator/cfx-server-data'

ui_page 'web/nui.html'

file 'web/nui.html'

client_script 'client/main.lua'

server_scripts {
    'server/main.lua',
    'server/web.lua'
}

shared_scripts {
    'shared/main.lua',
    'shared/runcode.js'
}

client_script 'client/ui.lua'