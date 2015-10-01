require 'minitest/autorun'
require 'minitest/pride'
require_relative 'district'
require_relative 'file_parser'
require_relative 'formatting'

class EconomicProfile

  attr_reader :district_data, :name

  def initialize(name, district_data)
    @free_or_reduced_lunch_by_year = district_data.fetch(:free_or_reduced_lunch)
    @school_aged_children_in_poverty_by_year = district_data.fetch(:school_aged_children_in_poverty)
    @title_1_students_by_year = district_data.fetch(:title_1_students)
  end

  def free_or_reduced_lunch_in_year(year)
    @free_or_reduced_lunch_by_year.values_at(year).pop
  end

  def free_or_reduced_lunch_by_year
    @free_or_reduced_lunch_by_year
  end

  def school_aged_children_in_poverty_by_year
    @school_aged_children_in_poverty_by_year
  end

  def school_aged_children_in_poverty_in_year(year)
    @school_aged_children_in_poverty_by_year.values_at(year).pop
  end

  def title_1_students_by_year
    @title_1_students_by_year
  end

  def title_1_students_in_year(year)
    @title_1_students_by_year.values_at(year).pop
  end
end
