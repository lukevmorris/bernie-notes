require_relative 'db.rb'
Dir["./lib/*.rb"].each { |file| require file }

Dotenv.load
DataLoader.sync

Rufus::Scheduler.new.every("20m") do
  DataLoader.sync
end

get "/" do
  @days = Call.by_day
  erb :index
end
