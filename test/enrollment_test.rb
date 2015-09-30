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
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.dropout_rate_by_race_in_year(2011)
  end

  def test_graduation_rate_by_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.graduation_rate_by_year
  end

  def test_graduation_rate_in_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.graduation_rate_in_year(2011)
  end

  def test_kindergarten_participation_by_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.kindergarten_participation_by_year
  end
  def test_kindergarten_participation_in_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.489, district.enrollment.kindergarten_participation_in_year(2011)
  end

  def test_online_participation_by_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.online_participation_by_year
  end

  def test_online_participation_in_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.online_participation_in_year(2012)
  end

  def test_participation_by_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.participation_by_year
  end

  def test_participation_in_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.participation_in_year(2012)
  end

  def test_participation_by_race_or_ethnicity
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.participation_by_race_or_ethnicity(:white)
  end

  def test_participation_by_race_or_ethnicity_in_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.participation_by_race_or_ethnicity_in_year(2012)
  end

  def test_special_education_by_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.special_education_by_year
  end

  def test_special_education_in_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.special_education_in_year(2012)
  end

  def test_remediation_by_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.remediation_by_year
  end

  def test_remediation_in_year
    skip
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.002, district.enrollment.remediation_in_year(2012)
  end
end
