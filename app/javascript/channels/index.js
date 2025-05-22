// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

# touched on 2025-05-22T20:38:26.102532Z
# touched on 2025-05-22T20:44:16.566234Z
# touched on 2025-05-22T22:43:21.059036Z