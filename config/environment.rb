
require 'bundler/setup'
Bundler.require

require 'active_record'
require 'rake'
# require_all 'app/models'
require_relative '../app/models/user.rb'
require_relative '../app/models/game.rb'
require_relative '../app/models/score.rb'

ENV["PLAYLISTER_ENV"] ||= "development"

# ActiveRecord::Base.establish_connection(ENV["PLAYLISTER_ENV"].to_sym)
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite')
require_all 'lib'

# ActiveRecord::Base.logger = nil

# if ENV["PLAYLISTER_ENV"] == "test"
#   ActiveRecord::Migration.verbose = false
# end
