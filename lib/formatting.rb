class UnknownDataError < StandardError
  def message
    "UnknownDataError"
  end
end

class UnknownRaceError < StandardError
  def message
    "UnknownRaceError"
  end
end
