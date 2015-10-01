class Formatting

  class UnknownDataError < StandardError
    def unknown_data
      raise UnknownDataError
    end

    def unknown_race
      raise UnknownRaceError
    end
  end

end
