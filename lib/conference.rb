class Conference < Sequel::Model
  one_to_many :calls, key: :conf_uid

  def self.build(raw)
    self.new do |conference|
      conference.uid = raw["UID"]
      conference.name = raw["name"]
    end
  end
end
