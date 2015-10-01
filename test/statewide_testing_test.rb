require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing'
require 'pry'

class StatewideTestingTest < Minitest::Test

  def test_grade_3_scores_by_subject
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_by_grade(3)

    assert_equal({2008=>{:math=>0.857, :reading =>0.866, :writing =>0.671},
                  2009=>{:math=>0.824, :reading =>0.862, :writing =>0.706},
                  2010=>{:math=>0.849, :reading =>0.864, :writing =>0.662},
                  2011=>{:math=>0.819, :reading =>0.867, :writing =>0.678},
                  2012=>{:math=>0.83,  :reading =>0.87,  :writing =>0.655},
                  2013=>{:math=>0.855, :reading =>0.859, :writing =>0.668},
                  2014=>{:math=>0.834, :reading =>0.831, :writing =>0.639},
                  }, district)
  end

  def test_grade_8_scores_by_subject
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_by_grade(8)

    assert_equal({2008=>{:math=>0.64, :reading=>0.843, :writing=>0.734},
                  2009=>{:math=>0.656, :reading=>0.825, :writing=>0.701},
                  2010=>{:math=>0.672, :reading=>0.863, :writing=>0.754},
                  2011=>{:reading=>0.832, :math=>0.653, :writing=>0.745},
                  2012=>{:math=>0.681, :writing=>0.738, :reading=>0.833},
                  2013=>{:math=>0.661, :reading=>0.852, :writing=>0.75},
                  2014=>{:math=>0.684, :reading=>0.827, :writing=>0.747}
                  }, district)
  end

  def test_proficient_for_subject_by_grade_in_year_grade_3_math
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)

    assert_equal 0.857, district
  end

  def test_proficient_for_subject_by_grade_in_year_grade_8_reading
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_for_subject_by_grade_in_year(:reading, 8, 2010)

    assert_equal 0.863, district
  end

  def test_proficient_for_subject_by_race_in_year_reading
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_for_subject_by_race_in_year(:reading, :asian, 2011)

    assert_equal 0.897, district
  end

  def test_proficient_for_subject_by_race_in_year_math
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ADAMS COUNTY 14")
                .statewide_testing.proficient_for_subject_by_race_in_year(:math, :white, 2012)

    assert_equal 0.333, district
  end

  def test_proficient_for_subject_by_race_in_year_writing
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("COLORADO")
                .statewide_testing.proficient_for_subject_by_race_in_year(:writing, :black, 2013)

    assert_equal 0.378, district
  end

  def test_proficient_for_subject_by_race_in_year_unknown_subject
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_for_subject_by_race_in_year(:history, :black, 2013)

    assert_raise "UnknownDataError", district
  end

  def test_proficient_by_race_or_ethnicity
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_by_race_or_ethnicity(:black)

    assert_equal "UnknownDataError", district
  end

  def test_proficient_for_subject_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_for_subject_in_year(:math, 2011)
                
    assert_equal 0.68, district
  end
end
