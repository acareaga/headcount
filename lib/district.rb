require './lib/district_repository'
require './lib/economic_profile'
require './lib/statewide_testing'
require './lib/enrollment'
require 'pry'

class District

  attr_accessor :name, :district_data

  def initialize(name, district_data)
    @name = name.upcase
    @district_data = district_data
  end

  def economic_profile
    EconomicProfile.new(name, district_data)
    # returns a new instance of the econ profile class
  end

  def statewide_testing
    StatewideTesting.new(data)
    # returns a new instance of the statewide class
  end

  def enrollment
    Enrollment.new(data)
    # returns a new instance of the enrollement class
  end

end

# def data
#   { economic_profile => {median_household_income, children_in_poverty, free_or_reduced_lunch, title_one_students },
#     statewide_testing => { # all files, },
#     enrollment => { # all files }
#   }
# end
