class DataLoader
  def self.sync
    MC::Conference.all.each { |raw_conf| load_conference(raw_conf) }
    true
  end

  def self.load_conference(raw)
    conference = Conference.find_or_create(uid: raw["UID"]) do |conf|
      conf.name = raw["name"]
    end
    raw["calls"].each do |call_uid|
      load_call(conference, call_uid) unless Call.find(uid: call_uid)
    end
  end

  def self.load_call(conference, uid)
    raw = MC::Call.find(conference.uid, uid)
    call = Call.build(conference, raw)
    raw["caller"].each { |person| load_person(call, person) }
  end

  def self.load_person(call, raw)
    Participant.build(call, raw)
  end
end
