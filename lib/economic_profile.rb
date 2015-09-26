require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'
require 'pry'

class EconomicProfile
# Represents data from these files:
# Median household income.csv
# School-aged children   in poverty.csv
# Students qualifying for free or reduced price lunch.csv
# Title I students.csv

  attr_reader :district_data, :name

  def initialize(name, district_data)
    @district_data = district_data
    # group by year, turn the years into keys
    # filter to just the percents
    # return years and data as integers
    # @free_or_reduced_lunch_by_year = district_data
    #               .select { |row| row.fetch(:dataformat) == "Percent" }
    #               .select { |row| row.fetch(:poverty_level) == "Eligible for Free or Reduced Lunch" }
    #               .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f] }.to_h
    # @school_aged_children_in_poverty_by_year = district_data
    #                 .select { |row| row.fetch(:dataformat) == "Percent" }
    #                 .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f]}.to_h
    @title_1_students_by_year = district_data
                    .map { |column| [column.fetch(:timeframe).to_i, column.fetch(:data).rjust(5, "0")[0..4].to_f]}.to_h
  end

  def free_or_reduced_lunch_in_year(year)
    @free_or_reduced_lunch_by_year.values_at(year).pop
  end

  def free_or_reduced_lunch_by_year
    @free_or_reduced_lunch_by_year
    # @district_data.values[0]
    # takes in a integer year
    # returns data representing a percentage
  end

  def school_aged_children_in_poverty_by_year
    @school_aged_children_in_poverty_by_year
    # returns a HASH with years as keys and
    # a floating point three-significant digits
    # representing a percentage or
    #empty hash if district is not in CSV data
  end

  def school_aged_children_in_poverty_in_year(year)
    @school_aged_children_in_poverty_by_year.values_at(year).pop
    # takes a year as an integer, returns a single three-digit
    # floating point percentage, unknown year returns nil
  end

  def title_1_students_by_year
    @title_1_students_by_year
    #returns a hash with yrs as keys and floating point 3-sigfig digits/percentage
    #returns empty hash if district's data is not in csv
  end

  def title_1_students_in_year(year)
    @title_1_students_by_year.values_at(year).pop
  end
end