require 'minitest/autorun'
require 'minitest/pride'
require_relative 'district'
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
    @proficient_by_grade_3 = district_data.fetch(:proficient_by_grade_3)
    @proficient_by_grade_8 = district_data.fetch(:proficient_by_grade_8)
    @math_proficiency = district_data.fetch(:math_proficiency)
    @math_proficiency_by_race = district_data.fetch(:math_proficiency_by_race)
    @reading_proficiency = district_data.fetch(:reading_proficiency)
    @reading_proficiency_by_race = district_data.fetch(:reading_proficiency_by_race)
    @writing_proficiency = district_data.fetch(:writing_proficiency)
    @writing_proficiency_by_race = district_data.fetch(:writing_proficiency_by_race)
  end


  def proficient_by_grade(grade)
    if grade == 3
      @proficient_by_grade_3
    elsif grade == 8
      @proficient_by_grade_8
    else
      puts "Unknown Grade Error"
    end
    # takes grade as an integer from the following set: [3, 8]
    # returns a hash grouped by year referencing percentages by subject all as three digit floats.
    # unknown grade should raise a UnknownDataError
  end

  def proficient_by_race_or_ethnicity(race)
      {:year => { :math    => @math_proficiency_by_race.fetch(race),
                  :reading => @reading_proficiency_by_race.fetch(race),
                  :writing => @writing_proficiency_by_race.fetch(race)}
      }
    # takes a race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # returns a hash grouped by race referencing percentages by subject all as truncated three digit floats
    # unknown race should raise a UnknownDataError
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if grade == 3
      @proficient_by_grade_3.values_at(year).pop.fetch(subject)
    elsif grade == 8
      @proficient_by_grade_8.values_at(year).pop.fetch(subject)
    else
      puts "UnknownDataError"
    end
    # subject as a symbol from the following set: [:math, :reading, :writing]
    # grade as an integer from the following set: [3, 8]
    # year as an integer for any year reported in the data
    # returns a truncated three-digit floating point number representing a percentage
    # any invalid parameter (like subject of :science) should raise a UnknownDataError
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    if subject == :math
      @math_proficiency.fetch(year).values_at(race).pop
    elsif subject == :reading
      @reading_proficiency.fetch(year).values_at(race).pop
    elsif subject == :writing
      @writing_proficiency.fetch(year).values_at(race).pop
    else subject == nil
      raise "UnknownDataError"
    end
    # subject as a symbol from the following set: [:math, :reading, :writing]
    # race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # year as an integer for any year reported in the data
    # returns a truncated three-digit floating point number representing a percentage
    # any invalid parameter (like subject of :history) should raise a UnknownDataError
  end

  def proficient_for_subject_in_year(subject, year)
    if subject == :math
      @math_proficiency.fetch(year).values_at(:all_students).pop
    elsif subject == :reading
      @reading_proficiency.fetch(year).values_at(:all_students).pop
    elsif subject == :writing
      @writing_proficiency.fetch(year).values_at(:all_students).pop
    else subject == nil
      raise "UnknownDataError"
    end
    # subject as a symbol from the following set: [:math, :reading, :writing]
    # year as an integer for any year reported in the data
    # returns a truncated three-digit floating point number representing a percentage
    # any invalid parameter (like subject of :history) should raise a UnknownDataError.
  end

end
