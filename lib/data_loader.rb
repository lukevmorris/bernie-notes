class DataLoader
  def self.load
    MC::Conference.all.each { |raw_conf| load_conference(raw_conf) }
  end

  def self.load_conference(raw)
    conference = Conference.build(raw)
    conference.save
    raw["calls"].each { |call_uid| load_call(conference, call_uid) }
  end

  def self.load_call(conference, uid)
    raw = MC::Call.find(conference.uid, uid)
    call = Call.build(raw)
    call.conference = conference
    call.save
    raw["caller"].each { |person| load_person(call, person) }
  end

  def self.load_person(call, raw)
    participant = Participant.build(raw)
    participant.call = call
    participant.save
  end
end
