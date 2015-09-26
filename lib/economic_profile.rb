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

  attr_reader :data, :name

  def initialize(data)
    @data = data
  end

  def free_or_reduced_lunch_in_year(year)
    data.values_at(year).pop
    #takes an integer, returns
  end

  def free_or_reduced_lunch_by_year
    data
    # @district_data.values[0]
    # takes in a integer year
    # returns data representing a percentage
  end

  def school_aged_children_in_poverty_by_year
    data
    # returns a HASH with years as keys and
    # a floating point three-significant digits
    # representing a percentage or
    #empty hash if district is not in CSV data
  end

  def school_aged_children_in_poverty_in_year(year)
    data.values_at(year).pop
    # takes a year as an integer, returns a single three-digit
    # floating point percentage, unknown year returns nil
  end

  def title_1_students_by_year
    #returns a hash with yrs as keys and floating point 3-sigfig digits/percentage
    #returns empty hash if district's data is not in csv
  end
end
