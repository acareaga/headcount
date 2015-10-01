require 'minitest/autorun'
require 'minitest/pride'
require './lib/economic_profile'
require 'pry'

class EconomicProfileTest < Minitest::Test

  def test_free_or_reduced_lunch_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.125, district.economic_profile.free_or_reduced_lunch_in_year(2012)
  end

  def test_district_repository_is_not_nil
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)

    assert_equal DistrictRepository, repository.class
  end

  def test_free_or_reduced_lunch_in_year_returns_nil_for_unknown_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal nil, district.economic_profile.free_or_reduced_lunch_in_year(3012)
  end

  def test_free_or_reduced_lunch_BY_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district = repository.find_by_name("ACADEMY 20")

    assert_equal({2014=>0.127, 2012=>0.125, 2011=>0.119, 2010=>0.113, 2009=>0.103, 2013=>0.131, 2008=>0.093, 2007=>0.08, 2006=>0.072, 2005=>0.058, 2004=>0.059, 2003=>0.06, 2002=>0.048, 2001=>0.047, 2000=>0.04}, district.economic_profile.free_or_reduced_lunch_by_year)
  end

  def test_it_finds_children_by_poverty_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district = repository.find_by_name("ACADEMY 20")

    assert_equal({1995=>0.032, 1997=>0.035, 1999=>0.032, 2000=>0.031, 2001=>0.029, 2002=>0.033, 2003=>0.037, 2004=>0.034, 2005=>0.042, 2006=>0.036, 2007=>0.039, 2008=>0.044, 2009=>0.047, 2010=>0.057, 2011=>0.059, 2012=>0.064, 2013=>0.048},
      district.economic_profile.school_aged_children_in_poverty_by_year)
  end

  def test_school_aged_children_in_poverty_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district = repository.find_by_name("ADAMS COUNTY 14")

    assert_equal 0.328, district.economic_profile.school_aged_children_in_poverty_in_year(2012)
  end

  def test_school_aged_children_in_poverty_in_year_returns_nil_for_unknown_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district = repository.find_by_name("ACADEMY 20")

    assert_equal nil, district.economic_profile.school_aged_children_in_poverty_in_year(2052)
  end

  def test_title_1_students_by_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district = repository.find_by_name("ACADEMY 20")

    assert_equal({2009=>0.014, 2011=>0.011, 2012=>0.01, 2013=>0.012, 2014=>0.027}, district.economic_profile.title_1_students_by_year)
  end

  def test_title_1_students_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district = repository.find_by_name("ACADEMY 20")

    assert_equal 0.012, district.economic_profile.title_1_students_in_year(2013)
  end

  def test_title_1_students_in_year_returns_nil_for_unfound_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district = repository.find_by_name("ACADEMY 20")
    
    assert_equal nil, district.economic_profile.title_1_students_in_year(2313)
  end
end
