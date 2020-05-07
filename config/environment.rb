
require 'bundler/setup'
Bundler.require

require 'active_record'
require 'rake'
require_relative '../app/models/user.rb'
require_relative '../app/models/game.rb'
require_relative '../app/models/score.rb'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite')
require_all 'lib'

