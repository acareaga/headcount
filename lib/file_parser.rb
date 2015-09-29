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
      build_districts(repo_data)
    # pass repo_data to file parsers

    # ECONOMIC PROFILE
    # parse_free_or_reduced_lunch_by_year
    # .parse_school_aged_children_in_poverty_by_year
    # .parse_title_1_students_by_year
    # # STATEWIDE TESTING
    # .parse_proficient_by_grade
    # ENROLLMENT
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
