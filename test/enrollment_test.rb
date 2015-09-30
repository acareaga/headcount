require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment'
require 'pry'

class EnrollmentTest < Minitest::Test

  def test_dropout_rate_in_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.dropout_rate_in_year(2011)
  end
end
