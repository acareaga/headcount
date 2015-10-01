require 'minitest/autorun'
require 'minitest/pride'
require_relative 'district'
require_relative 'formatting'

class StatewideTesting

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
      UnknownDataError
    end
  end

  def proficient_by_race_or_ethnicity(race)
    races = ["asian", "black", "pacific_islander", "hispanic", "native_american", "two_or_more", "white"]
    if races.include?(race.to_s)
    { 2011 => {:math => @math_proficiency_by_race.fetch(race).values_at(2011).pop, :reading => @reading_proficiency_by_race.fetch(race).values_at(2011).pop, :writing => @writing_proficiency_by_race.fetch(race).values_at(2011).pop},
      2012 => {:math => @math_proficiency_by_race.fetch(race).values_at(2012).pop, :reading => @reading_proficiency_by_race.fetch(race).values_at(2012).pop, :writing => @writing_proficiency_by_race.fetch(race).values_at(2012).pop},
      2013 => {:math => @math_proficiency_by_race.fetch(race).values_at(2013).pop, :reading => @reading_proficiency_by_race.fetch(race).values_at(2013).pop, :writing => @writing_proficiency_by_race.fetch(race).values_at(2013).pop},
      2014 => {:math => @math_proficiency_by_race.fetch(race).values_at(2014).pop, :reading => @reading_proficiency_by_race.fetch(race).values_at(2014).pop, :writing => @writing_proficiency_by_race.fetch(race).values_at(2014).pop}
    }
    else
      UnknownRaceError
    end
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if grade == 3
      @proficient_by_grade_3.values_at(year).pop.fetch(subject)
    elsif grade == 8
      @proficient_by_grade_8.values_at(year).pop.fetch(subject)
    else
      UnknownDataError
    end
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    if subject == :math
      @math_proficiency.fetch(year).values_at(race).pop
    elsif subject == :reading
      @reading_proficiency.fetch(year).values_at(race).pop
    elsif subject == :writing
      @writing_proficiency.fetch(year).values_at(race).pop
    else subject == nil
      UnknownDataError
    end
  end

  def proficient_for_subject_in_year(subject, year)
    if subject == :math
      @math_proficiency.fetch(year).values_at(:all_students).pop
    elsif subject == :reading
      @reading_proficiency.fetch(year).values_at(:all_students).pop
    elsif subject == :writing
      @writing_proficiency.fetch(year).values_at(:all_students).pop
    else subject == nil
      UnknownDataError
    end
  end
end
