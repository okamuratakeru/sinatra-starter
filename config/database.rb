# frozen_string_literal: true

require 'pg'

module Database
  def self.connect
    PG.connect(
      host: ENV.fetch('DB_HOST', 'localhost'),
      dbname: ENV.fetch('DB_NAME', 'memo_app'),
      user: ENV.fetch('DB_USER', ENV.fetch('USER', nil))
    )
  end
end
