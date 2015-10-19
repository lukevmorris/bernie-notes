class Participant < Sequel::Model
  many_to_one :call, key: :call_uid

  def self.build(raw)
    self.new do |participant|
      participant.name = raw["tag"]
      participant.email = raw["email"]
      participant.role = raw["role"]
    end
  end
end
