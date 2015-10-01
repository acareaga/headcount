require_relative 'district'
require_relative 'formatting'

class Enrollment

  attr_reader :district_data, :name, :dropout_rate_by_year

  def initialize(name, enrollment_data)
    @dropout_rate_by_year = enrollment_data.fetch(:dropout_rates)
    @graduation_rates = enrollment_data.fetch(:graduation_rates)
    @participation_by_year = enrollment_data.fetch(:pupil_enrollment)
    @kindergarten_participation = enrollment_data.fetch(:kindergarten_participation)
    @online_participation = enrollment_data.fetch(:online_participation)
    @pupil_enrollment_by_race_ethnicity = enrollment_data.fetch(:pupil_enrollment_by_race_ethnicity)
    @special_education = enrollment_data.fetch(:special_education)
    @remediation= enrollment_data.fetch(:remediation)
  end

  def dropout_rate_in_year(year)
    dropout_rate_by_year[:"all students"][year]
  end

  def dropout_rate_by_gender_in_year(year)
    { :female => dropout_rate_by_year[:"female students"][year],
      :male => dropout_rate_by_year[:"male students"][year] }
  end

  def dropout_rate_by_race_in_year(year)
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
    race = race.to_s + " students"
    dropout_rate_by_year[race.to_sym]
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    dropout_rate_by_race_in_year(year)[race]
  end

  def graduation_rate_by_year
    @graduation_rates
  end

  def graduation_rate_in_year(year)
    @graduation_rates.values_at(year).pop
  end

  def kindergarten_participation_by_year
    @kindergarten_participation
  end

  def kindergarten_participation_in_year(year)
    @kindergarten_participation.values_at(year).pop
  end

  def online_participation_by_year
    @online_participation
  end

  def online_participation_in_year(year)
    @online_participation.values_at(year).pop
  end

  def participation_by_year
    @participation_by_year
  end

  def participation_in_year(year)
    @participation_by_year.values_at(year).pop
  end

  def participation_by_race_or_ethnicity(race)
    race = race.to_s + " students"
    hash = @pupil_enrollment_by_race_ethnicity[race.to_sym]
    if hash == nil
      UnknownRaceError
    else
      hash
    end
  end

  def participation_by_race_or_ethnicity_in_year(year)
    { :asian => @pupil_enrollment_by_race_ethnicity[:"asian students"][year],
      :black => @pupil_enrollment_by_race_ethnicity[:"black students"][year],
      :hispanic => @pupil_enrollment_by_race_ethnicity[:"hispanic students"][year],
      :white => @pupil_enrollment_by_race_ethnicity[:"white students"][year],
      :native_american => @pupil_enrollment_by_race_ethnicity[:"american indian students"][year],
      :pacific_islander => @pupil_enrollment_by_race_ethnicity[:"native hawaiian or other pacific islander"][year],
      :two_or_more => @pupil_enrollment_by_race_ethnicity[:"two or more races"][year]
    }
  end

  def special_education_by_year
    @special_education
  end

  def special_education_in_year(year)
    @special_education.values_at(year).pop
  end

  def remediation_by_year
    @remediation
  end

  def remediation_in_year(year)
    @remediation.values_at(year).pop
  end
end
