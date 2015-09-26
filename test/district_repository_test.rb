require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'
require 'csv'
require 'pry'

class DistrictRepositoryTest < Minitest::Test
  def test_district_repo_class_exists
    repo_data = []
    repo = DistrictRepository.new(repo_data)
    assert_equal DistrictRepository, repo.class
  end

  def test_it_can_find_by_name
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20", district.name
  end

  def test_it_can_find_all_matching
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_all_matching("ACAD")
    assert_equal "ACADEMY 20", district.keys[0]
  end

  def test_find_by_name_returns_nil_when_dist_does_not_exist
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_by_name("DUHCADEMY 20")
    assert_equal nil, district
  end

  def test_find_by_name_is_case_insensitive
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_by_name("AcaDemY 20")
    assert_equal "ACADEMY 20", district.name
  end

  def test_find_all_matching_is_case_insensitive
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_all_matching("AcaDemY 20")
    assert_equal "ACADEMY 20", district.keys[0]
  end

  def test_find_all_matching_with_incomplete_name
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_all_matching("Acad")
    assert_equal "ACADEMY 20", district.keys[0]
  end

  def test_find_all_matching_with_incomplete_name_returns_nil
    skip  
    repository = DistrictRepository.from_csv('./test/data')
    district = repository.find_all_matching("duh")
    assert_equal [], district
  end
end
