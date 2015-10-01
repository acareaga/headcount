require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment'
require 'pry'

class EnrollmentTest < Minitest::Test

  def test_dropout_rate_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.dropout_rate_in_year(2011)
  end

  def test_dropout_rate_by_gender_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal h = {:female => 0.002, :male => 0.002}, district.enrollment.dropout_rate_by_gender_in_year(2011)
  end

  def test_dropout_rate_by_race_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal h = {:asian => 0,
                      :black => 0,
                      :hispanic => 0.004,
                      :white => 0.002,
                      :native_american => 0,
                      :pacific_islander=> 0,
                      :two_or_more=> 0 }, district.enrollment.dropout_rate_by_race_in_year(2011)
  end

  def test_dropout_rate_for_race_or_ethnicity
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal h = {2011 => 0, 2012 => 0.007}, district.enrollment.dropout_rate_for_race_or_ethnicity(:asian)
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal({:asian=>0.0, :black=>0.0, :hispanic=>0.004, :white=>0.002, :native_american=>0.0, :pacific_islander=>0.0, :two_or_more=>0.0},
      district.enrollment.dropout_rate_by_race_in_year(2011))
  end

  def test_graduation_rate_by_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal({ 2010 => 0.895,
                   2011 => 0.895,
                   2012 => 0.889,
                   2013 => 0.913,
                   2014 => 0.898}, district.enrollment.graduation_rate_by_year)
  end

  def test_graduation_rate_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.895, district.enrollment.graduation_rate_in_year(2011)
  end

  def test_kindergarten_participation_by_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal({ 2004 => 0.302,
                   2005 => 0.267,
                   2006 => 0.353,
                   2007 => 0.391,
                   2008 => 0.384,
                   2009 => 0.39,
                   2010 => 0.436,
                   2011 => 0.489,
                   2012 => 0.478,
                   2013 => 0.487,
                   2014 => 0.49}, district.enrollment.kindergarten_participation_by_year)
  end

  def test_kindergarten_participation_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.489, district.enrollment.kindergarten_participation_in_year(2011)
  end

  def test_online_participation_by_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal({ 2011 => 33,
                   2012 => 35,
                   2013 => 341
                   }, district.enrollment.online_participation_by_year)
  end

  def test_online_participation_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 35, district.enrollment.online_participation_in_year(2012)
  end

  def test_participation_by_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal({ 2009 => 22620, 2010 => 23119, 2011 => 23657, 2012 => 23973, 2013 => 24481, 2014 => 24578},
      district.enrollment.participation_by_year)
  end

  def test_participation_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 23973, district.enrollment.participation_in_year(2012)
  end

  def test_participation_by_race_or_ethnicity
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal({ 2007 => 0.05,
                   2008 => 0.054,
                   2009 => 0.055,
                   2010 => 0.04,
                   2011 => 0.036,
                   2012 => 0.038,
                   2013 => 0.038,
                   2014 => 0.037}, district.enrollment.participation_by_race_or_ethnicity(:asian))
  end

  def test_participation_by_race_or_ethnicity_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal({:asian=>0.038,
                  :black=>0.031,
                  :hispanic=>0.121,
                  :white=>0.75,
                  :native_american=>0.004,
                  :pacific_islander=>0.004,
                  :two_or_more=>0.053}, district.enrollment.participation_by_race_or_ethnicity_in_year(2012))
  end

  def test_special_education_by_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal({2009=>0.075,
                  2011=>0.079,
                  2012=>0.078,
                  2013=>0.079,
                  2010=>0.078,
                  2014=>0.079}, district.enrollment.special_education_by_year)
  end

  def test_special_education_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.078, district.enrollment.special_education_in_year(2012)
  end

  def test_remediation_by_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal({2011=>0.263,
                  2010=>0.294,
                  2009=>0.264}, district.enrollment.remediation_by_year)
  end

  def test_remediation_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.263, district.enrollment.remediation_in_year(2011)
  end
end
