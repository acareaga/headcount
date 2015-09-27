require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'
require 'pry'

class StatewideTesting
# Represents data from these files:
# 3rd grade students scoring proficient or above on the CSAP_TCAP.csv
# 8th grade students scoring proficient or above on the CSAP_TCAP.csv
# Average proficiency on the CSAP_TCAP by race_ethnicity_Math.csv
# Average proficiency on the CSAP_TCAP by race_ethnicity_Reading.csv
# Average proficiency on the CSAP_TCAP by race_ethnicity_Writing.csv
  attr_reader :district_data, :name

  def initialize(name, district_data)
    @district_data = district_data
    # zip multiple files together, use data as enumerable??

    @proficient_by_grade = district_data
      .select { |row| row.fetch(:score) == "Math" }
      .map { |column| [column.fetch(:timeframe).to_i, Hash[column.fetch(:score).downcase, column.fetch(:data).rjust(5, "0")[0..4].to_f]] }.to_h
  end

  def proficient_by_grade(grade)
    @proficient_by_grade
    # takes grade as an integer from the following set: [3, 8]
    # returns a hash grouped by year referencing percentages by subject all as three digit floats.
    # unknown grade should raise a UnknownDataError
  end

  def proficient_by_race_or_ethnicity(race)
    # takes a race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # returns a hash grouped by race referencing percentages by subject all as truncated three digit floats
    # unknown race should raise a UnknownDataError
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    # subject as a symbol from the following set: [:math, :reading, :writing]
    # grade as an integer from the following set: [3, 8]
    # year as an integer for any year reported in the data
    # returns a truncated three-digit floating point number representing a percentage
    # any invalid parameter (like subject of :science) should raise a UnknownDataError
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    # subject as a symbol from the following set: [:math, :reading, :writing]
    # race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # year as an integer for any year reported in the data
    # returns a truncated three-digit floating point number representing a percentage
    # any invalid parameter (like subject of :history) should raise a UnknownDataError
  end

  def proficient_for_subject_in_year(subject, year)
    # subject as a symbol from the following set: [:math, :reading, :writing]
    # year as an integer for any year reported in the data
    # returns a truncated three-digit floating point number representing a percentage
    # any invalid parameter (like subject of :history) should raise a UnknownDataError.
  end

end
