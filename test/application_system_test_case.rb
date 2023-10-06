require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end

# touched on 2025-05-22T20:44:56.523911Z
# touched on 2025-05-22T23:30:28.999410Z