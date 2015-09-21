require 'pry'

class DistrictRepository

  # recieves a String
  # returns a DistrictRepository
  def self.from_csv(path)
    filename  = 'Students qualifying for free or reduced price lunch.csv'
    fullpath  = File.join path, filename
    rows      = CSV.read(fullpath, headers: true, header_converters: :symbol) #.map { hash stuff }
    repo_data = ??

    DistrictRepository.new(repo_data)
  end
end

class TestEconomicProfile < Minitest::Test
  def test_free_or_reduced_lunch_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.125, district.economic_profile.free_or_reduced_lunch_in_year(2012)
  end
end
