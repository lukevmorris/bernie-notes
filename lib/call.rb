class Call < Sequel::Model
  many_to_one :conference, key: :conf_uid
  one_to_many :participants, key: :call_uid

  def self.build(raw)
    self.new do |call|
      call.uid = raw["call"]["UID"]
      call.start = raw["call"]["actualStartTime"]
    end
  end

  def self.by_day
    all_calls = reverse_order(:start).to_a
    all_calls.group_by(&:date).map do |date, calls|
      Day.new(date, calls)
    end
  end

  def callers
    participants_dataset
      .where(role: "PARTICIPANT")
      .to_a.uniq{|p| p.email}
      .size
  end

  def date
    start.strftime("%Y-%m-%d")
  end

  def time
    start.strftime("%H:%M")
  end

  def name
    conference.name
  end
end
