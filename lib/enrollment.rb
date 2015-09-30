require './lib/district'
require 'pry'

class Enrollment
  # Represents data from these files
    # Dropout rates by race and ethnicity.csv
    # High school graduation rates.csv
    # Kindergartners in full-day program.csv
    # Online pupil enrollment.csv
    # Pupil enrollment by race_ethnicity.csv
    # Pupil enrollment.csv
    # Special education.csv
    # Remediation in higher education.csv

  attr_reader :district_data, :name, :dropout_rate_by_year

  def initialize(name, enrollment_data)
    @dropout_rate_by_year = enrollment_data.fetch(:dropout_rates)
    @dropout_rate_by_gender_in_year
  end

  def dropout_rate_in_year(year)
    # returns a truncated three-digit floating point number representing a percentage
    # or nil for unknown year

    dropout_rate_by_year['All Students'][year] # FIXME :D
  end

  def dropout_rate_by_gender_in_year(year)
    # returns a hash with genders as keys and three-digit floating point number representing a percentage.
    # or nil
  end

  def dropout_rate_by_race_in_year(year)
    # returns a hash with race markers as keys and a three-digit floating
    #  point number representing a percentage or nil
  end

  def dropout_rate_for_race_or_ethnicity(race)
    # race as a symbol from the following set:
    # [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # returns a hash with years as keys and a three-digit floating
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    # returns a truncated three-digit floating point number representing a percentage
    # or nil
  end

  def graduation_rate_by_year
    # returns a hash with years as keys and a truncated three-digit floating point number representing a percentage.
  end

  def graduation_rate_in_year(year)
    # returns a truncated three-digit floating point number representing a percentage.
    # or nil
  end

  def kindergarten_participation_by_year
    # returns a hash with years as keys and a truncated three-digit floating point number representing a percentage
  end

  def kindergarten_participation_in_year(year)
    # returns a truncated three-digit floating point number representing a percentage.
    # or nil
  end

  def online_participation_by_year
    # returns a hash with years as keys and an integer as the value
  end

  def online_participation_in_year(year)
    # takes integer year, returns interger or nil for unknown year
  end

  def participation_by_year
    # returns a hash with years as keys and an integer as the value
  end

  def participation_in_year(year)
    # takes integer year, returns interger or nil for unknown year
  end

  def participation_by_race_or_ethnicity(race)
    # takes race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # returns a hash with years as keys and a three-digit floating point number representing a percentage
    # or UnknownRaceError
  end

  def participation_by_race_or_ethnicity_in_year(year)
    # returns a hash with race markers as keys and a three-digit floating point number representing a percentage.
  end

  def special_education_by_year
    # returns a hash with years as keys and an floating point three-significant digits representing a percentage.
  end

  def special_education_in_year(year)
    #  returns a single three-digit floating point percentage.
  end

  def remediation_by_year
    # method returns a hash with years as keys and an floating point three-significant digits representing a percentage.
  end

  def remediation_in_year(year)
    # method returns a single three-digit floating point percentage
    # or nil for unknown year
  end
end
