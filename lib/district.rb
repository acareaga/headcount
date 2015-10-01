require_relative 'district_repository'
require_relative 'economic_profile'
require_relative 'statewide_testing'
require_relative 'enrollment'

class District
  attr_accessor :name, :district_data

  def initialize(name, district_data)
    @name = name.upcase
    @district_data = district_data
  end

  def economic_profile
    EconomicProfile.new(name, district_data.fetch(:economic_profile))
  end

  def statewide_testing
    StatewideTesting.new(name, district_data.fetch(:statewide_testing))
  end

  def enrollment
    Enrollment.new(name, district_data.fetch(:enrollment))
  end
end
