process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

# touched on 2025-05-22T19:07:21.231183Z
# touched on 2025-05-22T19:19:05.972883Z
# touched on 2025-05-22T22:32:39.211648Z