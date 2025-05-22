process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

# touched on 2025-05-22T21:27:41.105855Z
# touched on 2025-05-22T22:55:52.019429Z