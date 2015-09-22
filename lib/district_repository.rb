require 'csv'
require 'pry'

class DistrictRepository

  attr_reader :district,

  def initialize
    @repo_data = repo_data
  end

  def find_by_name(district)
    # returns either nil or an instance of District having done a case insensitive search
    # make sure to downcase
    District.new || nil
  end

  def find_all_matching(fragment)
    #returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    # make sure to downcase
  end

  def economic_profile
    repo_data
    # collection of data sets for each district
    # move to class eventually
  end

  # recieves a String
  # returns a DistrictRepository
  def self.from_csv(path)
    filename  = 'Students qualifying for free or reduced price lunch.csv'
    fullpath  = File.join path, filename
    rows      = CSV.read(fullpath, headers: true, header_converters: :symbol).map { hash stuff }
    repo_data = rows(district, year)

    DistrictRepository.new
  end
end
