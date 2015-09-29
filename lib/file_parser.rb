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

  def file_loader
    @data = []
    parse_free_or_reduced_lunch_by_year
    # parse_school_aged_children_in_poverty_by_year
    # pass repo_data to file parsers

    # ECONOMIC PROFILE
    # parse_free_or_reduced_lunch_by_year
    # .parse_school_aged_children_in_poverty_by_year
    # .parse_title_1_students_by_year
    # # STATEWIDE TESTING
    # .parse_proficient_by_grade
    # ENROLLMENT
  end

  def group_by(repo_data)
    repo_data.group_by { |name| name[:location] }
  end

  # ECONOMIC PROFILE FILES -- finished migration, need to test
  def parse_free_or_reduced_lunch_by_year
    filename       = ['Students qualifying for free or reduced price lunch.csv']
    repo_data      = read_file(filename)
    h = group_by(repo_data)
    percent = h.map { |district, data| district = district, data = data
      .select { |row| row = row.fetch(:dataformat) == "Percent" }
      .select { |row| row = row.fetch(:poverty_level) == "Eligible for Free or Reduced Lunch" }
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.to_h }.to_h
    binding.pry

    #
    # percent = h.map { |district, data| district = district, data = data.select { |row|
    #   row = row.fetch(:dataformat) == "Percent" } }.to_h
    # data_type = percent.map { |district, data| district = district, data = data.select { |row|
    #   row = row.fetch(:poverty_level) == "Eligible for Free or Reduced Lunch" } }.to_h
    # formatted = data_type.map { |district, data| district = district, data = data.map { |column|
    #   [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.to_h }.to_h
      # row, [key.fetch(:dataformat) == "Percent"
      # } }
      # .rjust(5, "0")[0..4].to_f] ----
#     .select { |row| row.fetch(:dataformat) == "Percent" }
#     .select { |row| row.fetch(:poverty_level) == "Eligible for Free or Reduced Lunch" }
#     .group_by { |name, year, data| Hash[name[:location], Hash[:economic_profile, Hash[:free_or_reduced_lunch, :timeframe]]] }
# binding.pry
  repo_data.group_by { |district, rows|
    data = district.map { |year, data| year = year.fetch(:timeframe), data = data.fetch(:data)} }
  binding.pry
    # .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.to_h
   @data << file
  end

  # .group_by { |name| name[:location] }

  def parse_school_aged_children_in_poverty_by_year
    filename       = [ 'School-aged children in poverty.csv' ]
    repo_data      = read_file(filename)
        .select { |row| row.fetch(:dataformat) == "Percent" }
        .group_by { |name| name[:location] }.to_h
        .group_by { |file| :school_aged_children_in_poverty }
    @data << repo_data
      # .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.to_h
  end

  def parse_title_1_students_by_year
    filename = [ 'Title I students.csv' ]
      .each { |filename| read_file(filename) }
      .group_by { |name| name[:location] }
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.to_h
  end

  #STATEWIDE TESTING FILES -- need to fix select & mapping
  def parse_proficient_by_grade
    filename = [ '3rd grade students scoring proficient or above on the CSAP_TCAP.csv',
      '8th grade students scoring proficient or above on the CSAP_TCAP.csv' ]
      .each { |filename| read_file(filename) }
      .group_by { |name| name[:location] }
      .select { |row| row.fetch(:score) == "Math" } # add subject functionality so it's dynamic
      .map { |column| [column.fetch(:timeframe).to_i, Hash[column.fetch(:score).downcase, column.fetch(:data).rjust(5, "0")[0..4].to_f]] }.to_h
  end

  def parse_proficient_by_race_or_ethnicity
    filename = [ 'Average proficiency on the CSAP_TCAP by race_ethnicity_Math.csv',
      'Average proficiency on the CSAP_TCAP by race_ethnicity_Reading.csv',
      'Average proficiency on the CSAP_TCAP by race_ethnicity_Writing.csv' ]
      .each { |filename| read_file(filename) }
      .group_by { |name| name[:location] }
      .select { |row| row.fetch(:race_ethnicity) == "Asian" } # add race/ethnicity functionality so it's dynamic
      .map { |column| [column.fetch(:timeframe).to_i, Hash[column.fetch(:score).downcase, column.fetch(:data).rjust(5, "0")[0..4].to_f]] }.to_h
  end
  # ENROLLMENT FILES ...
end
