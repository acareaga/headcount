require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'
require 'csv'
require 'pry'

class DistrictRepositoryTest < Minitest::Test
  def test_district_repo_class_exists
    skip
    repo_data = []
    repo = DistrictRepository.new(repo_data)
    assert_equal DistrictRepository, repo.class
  end

  def test_it_holds_districts
    skip
    repository = DistrictRepository.from_csv('./test/data')
    repository.find_by_name
  end

  def test_it_can_find_by_name
    skip
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_by_name("ACADEMY 20")
  end

  def test_it_can_find_all_matching
    skip
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_all_matching("ACADEMY 20")
  end

  def test_find_by_name_returns_nil_when_dist_does_not_exist
    skip
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_by_name("DUHCADEMY 20")
  end

  def test_find_by_name_is_case_insensitive
    skip
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_by_name("Academy 20")
  end

  def test_find_all_matching_is_case_insensitive
    skip
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_all_matching("Academy 20")
  end

  def test_find_all_matching_with_incomplete_name
    skip
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_all_matching("Acad")
  end

  def test_find_all_matching_with_incomplete_name_returns_nil
    skip
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_all_matching("duh")
  end
end


class TestEconomicProfile < Minitest::Test

  def test_free_or_reduced_lunch_in_year
    path       = File.expand_path("./data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.125, district.economic_profile.free_or_reduced_lunch_in_year(2012)
  end

  def test_district_repository_is_not_nil
    skip
    repo_data  = [ "ACADEMY 20", {:district => 123}]
    repository = DistrictRepository.new(repo_data)
    refute_equal nil, repository
  end

  def test_something_about_economic_profile
    skip
    assert_equal 123, EconomicProfile.new({district_data: 123}).free_or_reduced_lunch_by_year
  end

end
