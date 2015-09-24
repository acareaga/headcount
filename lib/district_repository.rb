require 'csv'
require 'pry'

class EconomicProfile

  attr_reader :data, :name

  def initialize(data)
    @data = data
  end

  def free_or_reduced_lunch_in_year(year)
     data.values_at(year).pop
  end

  def free_or_reduced_lunch_by_year
    data
    # @district_data.values[0]
    # takes in a integer year
    # returns data representing a percentage
  end
end

class District

  attr_accessor :data

  def initialize(name, data)
    @name = name
    @data = data
  end

  def economic_profile
    EconomicProfile.new(data)
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

  def data
    {2000 => 0.020,
     2001 => 0.024,
     2002 => 0.027,
     2003 => 0.030,
     2004 => 0.034,
     2005 => 0.058,
     2006 => 0.041,
     2007 => 0.050,
     2008 => 0.061,
     2009 => 0.070,
     2010 => 0.079,
     2011 => 0.084,
     2012 => 0.125,
     2013 => 0.091,
     2014 => 0.087,
   }
  end

  def find_by_name(name)
    # @districts_by_name[:location]
    name = District.new(name, data)
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
