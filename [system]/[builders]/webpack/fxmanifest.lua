-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

<<<<<<< Updated upstream
version("2.0.1")
author("Cfx.re <root@cfx.re>")
description("Builds resources with webpack. To learn more: https://webpack.js.org")
repository("https://github.com/bitpredator/cfx-server-data")
=======
fx_version 'cerulean'
game 'common'
>>>>>>> Stashed changes

version '1.0.0'
author 'Cfx.re <root@cfx.re>'
description 'Builds resources with webpack 4. To learn more: https://v4.webpack.js.org'
repository 'https://github.com/bitpredator/cfx-server-data'

<<<<<<< Updated upstream
fx_version("cerulean")
game("common")
=======
server_script 'webpack_builder.js'

dependency 'yarn'
>>>>>>> Stashed changes
