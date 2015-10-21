class Conference < Sequel::Model
  unrestrict_primary_key
  one_to_many :calls, key: :conf_uid
end
