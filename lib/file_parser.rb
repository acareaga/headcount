require './lib/district_repository'
require 'csv'
require 'pry'

class FileParser
  attr_reader :path, :repo_data

  def initialize(path)
    @path = path
    @repo_data = repo_data
  end

  def read_file(filename) # joins path and reads file
    fullpath  = File.join path, filename
    repo_data = CSV.read(fullpath, headers: true, header_converters: :symbol).map(&:to_h)
  end

  # zip multiple files together, use data as enumerable??
  def file_loader(repo_data) # staging area to parse all files
    @repo_data.each { |repo_data| repo_data
      # pass repo_data to file parsers
      # ECONOMIC PROFILE
      .parse_free_or_reduced_lunch_by_year
      .parse_school_aged_children_in_poverty_by_year
      .parse_title_1_students_by_year
      # STATEWIDE TESTING
      .parse_proficient_by_grade
      # ENROLLMENT
    }
  end

  # ECONOMIC PROFILE FILES -- finished migration, need to test
  def parse_free_or_reduced_lunch_by_year
    filename = [ 'Students qualifying for free or reduced price lunch.csv' ]
      .each { |filename| read_file(filename) }
      .group_by { |name| name[:location] }
      .select { |row| row.fetch(:dataformat) == "Percent" }
      .select { |row| row.fetch(:poverty_level) == "Eligible for Free or Reduced Lunch" }
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.to_h
  end

  def parse_school_aged_children_in_poverty_by_year
    filename = [ 'School-aged children in poverty.csv' ]
      .each { |filename| read_file(filename) }
      .group_by { |name| name[:location] }
      .select { |row| row.fetch(:dataformat) == "Percent" }
      .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.to_h
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
