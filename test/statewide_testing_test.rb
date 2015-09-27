require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing'
require 'pry'

class StatewideTestingTest < Minitest::Test

  def test_whatev
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.125, district.statewide_testing.proficient_by_grade(3)
  end

end
