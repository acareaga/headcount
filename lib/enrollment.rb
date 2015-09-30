require_relative 'district'
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
    @participation_by_year = enrollment_data.fetch(:pupil_enrollment)
    @kindergarten_participation = enrollment_data.fetch(:kindergarten_participation)
    @online_participation = enrollment_data.fetch(:online_participation)
    @pupil_enrollment_by_race_ethnicity = enrollment_data.fetch(:pupil_enrollment_by_race_ethnicity)
    @special_education = enrollment_data.fetch(:special_education)
    @remediation= enrollment_data.fetch(:remediation)
  end

  def dropout_rate_in_year(year)
    # returns a truncated three-digit floating point number representing a percentage
    # or nil for unknown year
    dropout_rate_by_year[:"all students"][year] # FIXME :D
  end

  def dropout_rate_by_gender_in_year(year)
    # returns a hash with genders as keys and three-digit floating point number representing a percentage.
    # or nil
    { :female => dropout_rate_by_year[:"female students"][year],
      :male => dropout_rate_by_year[:"male students"][year] }
    # [year], dropout_rate_by_year[:"male students"]
  end

  def dropout_rate_by_race_in_year(year)
    # returns a hash with race markers as keys and a three-digit floating
    #  point number representing a percentage or nil
    { :asian => dropout_rate_by_year[:"asian students"][year],
      :black => dropout_rate_by_year[:"black students"][year],
      :hispanic => dropout_rate_by_year[:"hispanic students"][year],
      :white => dropout_rate_by_year[:"white students"][year],
      :native_american => dropout_rate_by_year[:"native american students"][year],
      :pacific_islander => dropout_rate_by_year[:"native hawaiian or other pacific islander"][year],
      :two_or_more => dropout_rate_by_year[:"two or more races"][year]
    }
  end

  def dropout_rate_for_race_or_ethnicity(race)
    # race as a symbol from the following set:
    # [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # returns a hash with years as keys and a three-digit floating
    race = race.to_s + " students"
    dropout_rate_by_year[race.to_sym]
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
    @participation_by_year
    # returns a hash with years as keys and an integer as the value
  end

  def participation_in_year(year)
    @participation_by_year.values_at(year).pop
    # takes integer year, returns interger or nil for unknown year
  end

  def participation_by_race_or_ethnicity(race)
    @participation_by_race_or_ethnicity.fetch(race)
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
