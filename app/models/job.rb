class Job < ApplicationRecord
  RETRY_LIMIT = 3
  enum state: { waiting: 1, in_process: 2, done: 3, failed: 4, skip:5 }, _default: 'waiting'
end
