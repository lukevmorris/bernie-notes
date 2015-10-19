class Day
  attr_reader :date, :calls
  def initialize(date, calls)
    @date = date
    @calls = calls
  end

  def callers
    calls.map(&:callers).reduce(0, :+)
  end
end
