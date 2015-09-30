require './lib/district_repository'
require 'csv'
require 'pry'

class FileParser
  attr_reader :path, :repo_hash, :filename, :data

  def initialize(path)
    @path      = path
    @filename  = filename
    @repo_hash = {}
  end

  def read_file(file_name) # joins path and reads file
    fullpath = File.join path, file_name
    rows     = CSV.read(fullpath, headers: true, header_converters: :symbol)
    rows.map(&:to_h).group_by { |row| row.fetch(:location) }
  end

  def file_loader # need to save result as data hash, create district framework below
    parse_free_or_reduced_lunch_by_year
    parse_school_aged_children_in_poverty_by_year
    parse_title_1_students_by_year
    parse_dropout_rate
    parse_graduation_rates
    parse_kindergarten_participation
    parse_online_participation
    parse_pupil_enrollment
    parse_pupil_enrollment_by_race_ethnicity
    parse_special_education
    parse_remediation
    parse_proficient_by_grade_3
    parse_proficient_by_grade_8
    parse_math_proficiency
    parse_reading_proficiency
    parse_writing_proficiency
    repo_hash
    binding.pry
  end

  def economic_profile_for(name)
    ensure_name(name)[:economic_profile]
  end

  def statewide_testing_for(name)
    ensure_name(name)[:statewide_testing]
  end

  def enrollment_for(name)
    ensure_name(name)[:enrollment]
  end

  def ensure_name(name)
    repo_hash[name.upcase] ||= {
      economic_profile:  {},
      statewide_testing: {},
      enrollment:        {},
    }
  end

  def parse_math_proficiency
    filename = 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv'
    read_file(filename).each do |name, rows|
      data = rows.group_by { |row| row.fetch(:race_ethnicity) }
                 .map { |race_ethnicity, rows|
                   years_to_percentages = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
                   [race_ethnicity, years_to_percentages]
                 }
                 .to_h
      statewide_testing_for(name)[:math_proficiency] = data
    end
  end

  def parse_reading_proficiency
    filename = 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv'
    read_file(filename).each do |name, rows|
      data = rows.group_by { |row| row.fetch(:race_ethnicity) }
                 .map { |race_ethnicity, rows|
                   years_to_percentages = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
                   [race_ethnicity, years_to_percentages]
                 }
                 .to_h
      statewide_testing_for(name)[:reading_proficiency] = data
    end
  end

  def parse_writing_proficiency
    filename = 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv'
    read_file(filename).each do |name, rows|
      data = rows.group_by { |row| row.fetch(:race_ethnicity) }
                 .map { |race_ethnicity, rows|
                   years_to_percentages = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
                   [race_ethnicity, years_to_percentages]
                 }
                 .to_h
      statewide_testing_for(name)[:writing_proficiency] = data
    end
  end

  def parse_proficient_by_grade_3
    filename = '3rd grade students scoring proficient or above on the CSAP_TCAP.csv'
    read_file(filename).each do |name, rows|
      data = rows.group_by { |row| row.fetch(:score) }
                 .map { |subject, rows|
                   percent_by_year = rows.map { |row|
                                           [ row.fetch(:timeframe).to_i,
                                             row.fetch(:data)[0..4].to_f
                                           ]
                                         }
                                         .to_h
                   [subject, percent_by_year]
                 }.to_h
      statewide_testing_for(name)[:proficient_by_grade_3] = data
    end
  end

  def parse_proficient_by_grade_8
    filename = '8th grade students scoring proficient or above on the CSAP_TCAP.csv'
    read_file(filename).each do |name, rows|
      data = rows.group_by { |row| row.fetch(:score) }
                 .map { |subject, rows|
                   percent_by_year = rows.map { |row|
                                           [ row.fetch(:timeframe).to_i,
                                             row.fetch(:data)[0..4].to_f
                                           ]
                                         }
                                         .to_h
                   [subject, percent_by_year]
                 }.to_h
      statewide_testing_for(name)[:proficient_by_grade_8] = data
    end
  end

  # ENROLLMENT FILES ...
  def parse_dropout_rate
    filename  = 'Dropout rates by race and ethnicity.csv'
    read_file(filename).each do |name, rows|
      data = rows.group_by { |row| row.fetch :category }
      .map { |race, rows|
        percents_by_year = rows.map { |row|
          [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f]
        }.to_h
        [race, percents_by_year]
      }.to_h
      enrollment_for(name)[:dropout_rates] = data
    end
  end

  def parse_graduation_rates
    filename  = 'High school graduation rates.csv'
    read_file(filename).each do |name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      enrollment_for(name)[:graduation_rates] = data
    end
  end

  def parse_kindergarten_participation
    filename  = 'Kindergartners in full-day program.csv'
    read_file(filename).each do |name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      enrollment_for(name)[:kindergarten_participation] = data
    end
  end

  def parse_online_participation
    filename  = 'Online pupil enrollment.csv'
    read_file(filename).each do |name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      enrollment_for(name)[:online_participation] = data
    end
  end

  def parse_pupil_enrollment
    filename  = 'Pupil enrollment.csv'
    read_file(filename).each do |name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data).to_i] }.to_h
      enrollment_for(name)[:pupil_enrollment] = data
    end
  end

  def parse_pupil_enrollment_by_race_ethnicity
    filename  = 'Pupil enrollment by race_ethnicity.csv'
    read_file(filename).each do |name, rows|
      data = rows.select { |row| row.fetch(:dataformat) == "Percent" }
                 .group_by { |row| row.fetch(:race) }
                 .map { |race, rows|
                   percent_by_year = rows.map { |row|
                     [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f]
                   }.to_h
                   [race, percent_by_year]
                 }
                 .to_h
      enrollment_for(name)[:pupil_enrollment_by_race_ethnicity] = data
    end
  end

  def parse_special_education
    filename  = 'Special education.csv'
    read_file(filename).each do |name, rows|
      data = rows.select { |row| row.fetch(:dataformat) == 'Percent' }
                 .map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }
                 .to_h
      enrollment_for(name)[:special_education] = data
    end
  end

  def parse_remediation
    filename  = 'Remediation in higher education.csv'
    read_file(filename).each do |name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }.to_h
      enrollment_for(name)[:remediation] = data
    end
  end

  # ECONOMIC PROFILE FILES -- finished migration, need to test
  def parse_free_or_reduced_lunch_by_year
    filename = 'Students qualifying for free or reduced price lunch.csv'
    read_file(filename).each do |name, rows|
      data = rows.select { |row| row.fetch(:dataformat) == "Percent" && row.fetch(:poverty_level) == "Eligible for Free or Reduced Lunch" }
                 .map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }
                 .sort
                 .to_h
      economic_profile_for(name)[:free_or_reduced_lunch] = data
    end
  end

  def parse_school_aged_children_in_poverty_by_year
    filename = 'School-aged children in poverty.csv'
    read_file(filename).each do |name, rows|
      data = rows.select { |row| row.fetch(:dataformat) == "Percent" }
                 .map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }
                 .sort
                 .to_h
      economic_profile_for(name)[:school_aged_children_in_poverty] = data
    end
  end

  def parse_title_1_students_by_year
    filename = 'Title I students.csv'
    read_file(filename).each do |name, rows|
      data = rows.map { |row| [row.fetch(:timeframe).to_i, row.fetch(:data)[0..4].to_f] }
                 .sort
                 .to_h
      economic_profile_for(name)[:title_1_students] = data
    end
  end
end
