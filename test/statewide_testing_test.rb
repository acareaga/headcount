require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_testing'
require 'pry'

class StatewideTestingTest < Minitest::Test

  def test_grade_3_scores_by_subject_math
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_by_grade(3)
    assert_equal h = {2008=>{"math"=>0.857}, 2009=>{"math"=>0.824}, 2010=>{"math"=>0.849}, 2011=>{"math"=>0.819}, 2012=>{"math"=>0.83}, 2013=>{"math"=>0.855}, 2014=>{"math"=>0.834}}, district
  end

  def test_grade_3_scores_by_subject_reading
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_by_grade(3)
    assert_equal h = {2008=>{"reading"=>0.866}, 2009=>{"reading"=>0.862}, 2010=>{"reading"=>0.864}, 2011=>{"reading"=>0.867}, 2012=>{"reading"=>0.87}, 2013=>{"reading"=>0.859}, 2014=>{"reading"=>0.831}}, district
  end

  def test_grade_3_scores_by_subject_writing
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_by_grade(3)
    assert_equal h = {2008=>{"math"=>0.64}, 2009=>{"math"=>0.656}, 2010=>{"math"=>0.672}, 2011=>{"math"=>0.653}, 2012=>{"math"=>0.681}, 2013=>{"math"=>0.661}, 2014=>{"math"=>0.684}}, district
  end

  def test_grade_8_scores_by_subject
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
                .statewide_testing.proficient_by_grade(8)
    assert_equal h = {2008=>{"math"=>0.857}, 2009=>{"math"=>0.824}, 2010=>{"math"=>0.849}, 2011=>{"math"=>0.819}, 2012=>{"math"=>0.83}, 2013=>{"math"=>0.855}, 2014=>{"math"=>0.834}}, district
  end

  # def test_grade_8_scores_by_subject_reading
  #   skip
  #   path       = File.expand_path("./data", __dir__)
  #   repository = DistrictRepository.from_csv(path)
  #   district   = repository.find_by_name("ACADEMY 20")
  #               .statewide_testing.proficient_by_grade(8)
  #   assert_equal h = {2008=>{"reading"=>0.843}, 2009=>{"reading"=>0.825}, 2010=>{"reading"=>0.863}, 2011=>{"reading"=>0.832}, 2012=>{"reading"=>0.833}, 2013=>{"reading"=>0.852}, 2014=>{"reading"=>0.827}}, district
  # end
  #
  # def test_grade_8_scores_by_subject_writing
  #   skip
  #   path       = File.expand_path("./data", __dir__)
  #   repository = DistrictRepository.from_csv(path)
  #   district   = repository.find_by_name("ACADEMY 20")
  #               .statewide_testing.proficient_by_grade(8)
  #   assert_equal h = {2008=>{"writing"=>0.734}, 2009=>{"writing"=>0.701}, 2010=>{"writing"=>0.754}, 2011=>{"writing"=>0.745}, 2012=>{"writing"=>0.738}, 2013=>{"writing"=>0.75}, 2014=>{"writing"=>0.747}}, district
  # end
  #
  # def test_proficient_by_race_or_ethnicity
  #   skip
  #   path       = File.expand_path("./data", __dir__)
  #   repository = DistrictRepository.from_csv(path)
  #   district   = repository.find_by_name("ACADEMY 20")
  #               .statewide_testing.proficient_by_race_or_ethnicity(race)
  #   assert_equal
  # end
end
