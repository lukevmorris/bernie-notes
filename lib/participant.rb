class Participant < Sequel::Model
  many_to_one :call, key: :call_uid

  def self.build(call, raw)
    self.create do |participant|
      participant.name = raw["tag"]
      participant.email = raw["email"]
      participant.role = raw["role"]
      participant.call = call
    end
  end
end
