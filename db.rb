require 'sqlite3'
require 'sequel'

DB = Sequel.sqlite

DB.create_table :conferences do
  String :uid, primary_key: true
  String :name
end

DB.create_table :calls do
  String :uid, primary_key: true
  foreign_key :conf_uid, :conferences, type: String
  Time :start
end

DB.create_table :participants do
  primary_key :id
  foreign_key :call_uid, :calls, type: String
  String :email
  String :role
  String :name
end
