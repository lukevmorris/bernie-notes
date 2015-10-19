require_relative 'db.rb'
Dir["./lib/*.rb"].each { |file| require file }

Dotenv.load
DataLoader.load

get "/" do
  @days = Call.by_day
  erb :index
end
