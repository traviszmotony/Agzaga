class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end

# touched on 2025-05-22T20:41:08.719956Z
# touched on 2025-05-22T23:28:52.521903Z
# touched on 2025-05-22T23:42:00.974043Z
# touched on 2025-05-22T23:45:26.279015Z