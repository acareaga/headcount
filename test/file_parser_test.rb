require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class FileParserTest < Minitest::Test

  def test_average_proficiency_by_subject_math_parses_correctly
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)

    assert_equal 0.857, district
  end

  def test_dropout_rates_by_race_and_ethnicity_parses_correctly
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.dropout_rate_in_year(2011)
  end

  def test_school_aged_children_in_poverty_parses_correctly
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district = repository.find_by_name("ADAMS COUNTY 14")

    assert_equal hash = 0.328, district.economic_profile.school_aged_children_in_poverty_in_year(2012)
  end

end
