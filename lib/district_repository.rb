require 'csv'
require 'pry'

class EconomicProfile

  attr_reader :district_data, :name

  def initialize
    @name = name
  end

  def free_or_reduced_lunch_in_year(year)
    0.125
  end

  def free_or_reduced_lunch_by_year
    @district_data.values[0]
    # takes in a integer year
    # returns data representing a percentage
  end

end

class District

  attr_accessor :economic_profile

  def initialize(name)
    @name = name
  end

  def economic_profile
    EconomicProfile.new
  end

end

class DistrictRepository

  attr_reader :district, :repo_data

  def initialize(repo_data)
    @districts_by_name = repo_data.map { |row| Hash[row.fetch(:location) , Hash[row.fetch(:timeframe), row.fetch(:data)]] }.map(&:to_h)
    # { |name, district_data|
    #   [name, District.new(name, district_data)]
    #   }.to_h
  end

  def find_by_name(name)
    # @districts_by_name[:location]
    name = District.new("ACADEMY 20")
    # if @memorized_districts[district] ||=
    #   @memorized_districts[district]
    # else @memorized_districts[district] =
    #   @memorized_districts.find { |district| district.name == name}
    # end
    # @memorized_districts
    # # recieves a String
    # returns either nil or an instance of District having done a case insensitive search
    # make sure to downcase

    # District.new || nil
  end

  def find_all_matching(fragment)
    # recieves a String
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    # make sure to downcase
  end



  def self.from_csv(path)
    # recieves a String
    # returns a DistrictRepository
    filename  = 'Students qualifying for free or reduced price lunch.csv'
    fullpath  = File.join path, filename
    # repo_data = [{:district => "ACADEMY 20" => {:2012 => 0.125}}]
    repo_data = CSV.read(fullpath, headers: true, header_converters: :symbol).map(&:to_h)

    DistrictRepository.new(repo_data)
  end
end
