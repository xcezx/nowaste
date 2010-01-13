require 'sequel'
require 'sequel/extensions/migration'

namespace :db do
  DB = Sequel.connect(:adapter => "sqlite", :database => "nowaste.db")

  desc "Migrate database"
  task :migrate do
    Sequel::Migrator.apply(DB, './db/migrate')
  end
end










