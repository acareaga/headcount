require 'csv'
require 'pry'

class DistrictRepository

  attr_reader :district,

  def initialize
    @repo_data = repo_data
  end

  def find_by_name(district)
    # recieves a String
    # returns either nil or an instance of District having done a case insensitive search
    # make sure to downcase
    District.new || nil
  end

  def find_all_matching(fragment)
    # recieves a String
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    # make sure to downcase
  end

  def economic_profile
    repo_data
    # collection of data sets for each district
    # move to class eventually
  end

  def self.from_csv(path)
    # recieves a String
    # returns a DistrictRepository
    filename  = 'Students qualifying for free or reduced price lunch.csv'
    fullpath  = File.join path, filename
    rows      = CSV.read(fullpath, headers: true, header_converters: :symbol).map {
                  |row| [row.fetch(:key), row.fetch(:value)] }.map(&:to_h)
    repo_data = rows(district, year)

    DistrictRepository.new
  end
end
