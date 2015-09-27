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
    # returns a new instance of the economic_profile class
  end

  def statewide_testing
    StatewideTesting.new(name, district_data)
    # returns a new instance of the statewide_testing class
  end

  def enrollment
    Enrollment.new(name, district_data)
    # returns a new instance of the enrollement class
  end
end
