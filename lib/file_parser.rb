require './lib/district_repository'
require 'csv'
require 'pry'

class FileParser
  attr_reader :path, :repo_data, :filename, :data

  def initialize(path)
    @path = path
    @repo_data = repo_data
    @filename = filename
  end

  def read_file(file_name) # joins path and reads file
    fullpath  = File.join path, file_name
    repo_data = CSV.read(fullpath, headers: true, header_converters: :symbol).map(&:to_h)
  end

  def file_loader # need to save result as data hash, create district framework below
    @repo_data = []
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
    build_districts(repo_data)
    binding.pry
  end

  #STATEWIDE TESTING FILES -- need to fix select & mapping
  def parse_math_proficiency
    filename = [ 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv' ]
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    math = districts.map { |district, data| district = district, data = data
      .map { |column| Hash[column.fetch(:race_ethnicity), Hash[column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] ] } }
      .map { |key, value| key = key, Hash[:math_proficiency, value] }.to_h
    @repo_data << math
  end

  def parse_reading_proficiency
    filename = [ 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv' ]
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    reading = districts.map { |district, data| district = district, data = data
      .map { |column| Hash[column.fetch(:race_ethnicity), Hash[column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] ] } }
      .map { |key, value| key = key, Hash[:reading_proficiency, value] }.to_h
    @repo_data << reading
  end

  def parse_writing_proficiency
    filename = [ 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv' ]
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    writing = districts.map { |district, data| district = district, data = data
      .map { |column| Hash[column.fetch(:race_ethnicity), Hash[column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] ] } }
      .map { |key, value| key = key, Hash[:writing_proficiency, value] }.to_h
    @repo_data << writing
  end

  def parse_proficient_by_grade_3
    filename = [ '3rd grade students scoring proficient or above on the CSAP_TCAP.csv' ]
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    third_grade = districts.map { |district, data| district = district, data = data
      .map { |column| Hash[column.fetch(:score), Hash[column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] ] } }
      .map { |key, value| key = key, Hash[:proficient_by_grade_3, value] }.to_h
    @repo_data << third_grade
  end

  def parse_proficient_by_grade_8
    filename = [ '8th grade students scoring proficient or above on the CSAP_TCAP.csv' ]
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    eighth_grade = districts.map { |district, data| district = district, data = data
      .map { |column| Hash[column.fetch(:score), Hash[column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] ] } }
      .map { |key, value| key = key, Hash[:proficient_by_grade_8, value] }.to_h
    @repo_data << eighth_grade
  end

  # ENROLLMENT FILES ...
  def parse_dropout_rate
    filename  = ['Dropout rates by race and ethnicity.csv']
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    all_dropouts = districts.map { |district, data| district = district, data = data
      .map { |column| Hash[column.fetch(:category), Hash[column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f]] }}
      .group_by { |category| }
      .map { |key, value| key = key, Hash[:dropout_rates, value] }.to_h
    @repo_data << all_dropouts
  end

  def parse_graduation_rates
    filename  = ['High school graduation rates.csv']
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    grad_rates = districts.map { |district, data| district = district, data = data
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.sort.to_h }
      .map { |key, value| key = key, Hash[:graduation_rates, value] }.to_h
    @repo_data << grad_rates
  end

  def parse_kindergarten_participation
    filename  = ['Kindergartners in full-day program.csv']
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    participation_rates = districts.map { |district, data| district = district, data = data
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.sort.to_h }
      .map { |key, value| key = key, Hash[:kindergarten_participation, value] }.to_h
    @repo_data << participation_rates
  end

  def parse_online_participation
    filename  = ['Online pupil enrollment.csv']
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    participation_rates = districts.map { |district, data| district = district, data = data
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).to_i] }.sort.to_h }
      .map { |key, value| key = key, Hash[:online_participation, value] }.to_h
    @repo_data << participation_rates
  end

  def parse_pupil_enrollment
    filename  = ['Pupil enrollment.csv']
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    participation_rates = districts.map { |district, data| district = district, data = data
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).to_i] }.sort.to_h }
      .map { |key, value| key = key, Hash[:pupil_enrollment, value] }.to_h
    @repo_data << participation_rates
  end

  def parse_pupil_enrollment_by_race_ethnicity
    filename  = ['Pupil enrollment by race_ethnicity.csv']
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    participation_rates = districts.map { |district, data| district = district, data = data
      .select { |row| row = row.fetch(:dataformat) == "Percent"}
      .group_by { |row| row.fetch(:race) }
      .map { |key, rows|
        rows.map { |row|
          :timeframe # Hash[row.fetch(:timeframe).to_i, row.fetch(:data).rjust(5, "0")[0..4].to_f]
        }
        [key, ??]
      }
      .to_h
    @repo_data << { :pupil_enrollment_by_race_ethnicity => participation_rates }
  end

  def parse_special_education
    filename  = ['Special education.csv']
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    special_education = districts.map { |district, data| district = district, data = data
      .select { |row| row = row.fetch(:dataformat) == "Percent"}
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.sort.to_h }
      .map { |key, value| key = key, Hash[:special_education, value] }.to_h
    @repo_data << special_education
  end

  def parse_remediation
    filename  = ['Remediation in higher education.csv']
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    remediation = districts.map { |district, data| district = district, data = data
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.sort.to_h }
      .map { |key, value| key = key, Hash[:remediation, value] }.to_h
    @repo_data << remediation
  end

  # ECONOMIC PROFILE FILES -- finished migration, need to test
  def parse_free_or_reduced_lunch_by_year
    filename  = ['Students qualifying for free or reduced price lunch.csv']
    repo_data = read_file(filename)
    districts = group_by(repo_data)
    percent   = districts.map { |district, data| district = district, data = data
      .select { |row| row = row.fetch(:dataformat) == "Percent" && row = row.fetch(:poverty_level) == "Eligible for Free or Reduced Lunch" }
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.sort.to_h }
      .map { |key, value| key = key, Hash[:free_or_reduced_lunch, value] }.to_h
    @repo_data << percent
  end

  def parse_school_aged_children_in_poverty_by_year
    filename       = [ 'School-aged children in poverty.csv' ]
    repo_data      = read_file(filename)
    h = group_by(repo_data)
    percent = h.map { |district, data| district = district, data = data
      .select { |row| row = row.fetch(:dataformat) == "Percent" }
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.sort.to_h }
      .map { |key, value| key = key, Hash[:school_aged_children_in_poverty, value] }.to_h
    @repo_data << percent
  end

  def parse_title_1_students_by_year
    filename  = [ 'Title I students.csv' ]
    repo_data = read_file(filename)
    h = group_by(repo_data)
    percent = h.map { |district, data| district = district, data = data
      .select { |row| row = row.fetch(:dataformat) == "Percent" }
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.sort.to_h }
      .map { |key, value| key = key, Hash[:title_1_students, value] }.to_h
    @repo_data << percent
  end

  def build_districts(array)
    keys = []
    result = {}

    array.each do |district|
      keys += district.keys
    end

    keys.uniq.each do |key|
      result[key] = []
      array.each do |district|
        result[key] << district[key]
      end
    end
    result
  end

  def group_by(repo_data)
    repo_data.group_by { |name| name[:location].upcase }
  end

  ### FLOATS ####################
    class Float
      def inspect
        '%.3f' % self
      end
    end

    def truncate(percentage)
      (percentage.to_f * 1000).to_i / 1000
    end
  ####################
end
