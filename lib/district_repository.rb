require 'csv'
require 'pry'

class EconomicProfile
# Represents data from these files:
# Median household income.csv
# School-aged children   in poverty.csv
# Students qualifying for free or reduced price lunch.csv
# Title I students.csv

  attr_reader :data, :name

  def initialize(data)
    @data = data
  end

  def free_or_reduced_lunch_in_year(year)
    data.values_at(year).pop
    #takes an integer, returns
  end

  def free_or_reduced_lunch_by_year
    data
    # @district_data.values[0]
    # takes in a integer year
    # returns data representing a percentage
  end

  def school_aged_children_in_poverty_by_year
    data
    # returns a HASH with years as keys and
    # a floating point three-significant digits
    # representing a percentage or
    #empty hash if district is not in CSV data
  end

  def school_aged_children_in_poverty_in_year(year)
    data.values_at(year).pop
    # takes a year as an integer, returns a single three-digit
    # floating point percentage, unknown year returns nil
  end

  def title_1_students_by_year
    #returns a hash with yrs as keys and floating point 3-sigfig digits/percentage
    #returns empty hash if district's data is not in csv
  end
end

class District

  attr_accessor :data, :districts_by_name

  def initialize(name, district_data)
    @name = name
    @district_data = district_data
  end

  def name
    @name
  end

  # def data
  #   { economic_profile => {median_household_income, children_in_poverty, free_or_reduced_lunch, title_one_students },
  #     statewide_testing => { # all files, },
  #     enrollment => { # all files }
  #   }
  # end

  def economic_profile
    EconomicProfile.new(data)
  end

  def statewide_testing
    StatewideTesting.new(data)
  end

  def enrollment
    Enrollment.new(data)
  end

end

class DistrictRepository

  attr_reader :district, :districts_by_name

  def initialize(repo_data)
    @districts_by_name = repo_data.group_by { |name| name[:location]}
    @districts_by_name.map { |name, district_data|
      [name, District.new(name, district_data)]
      }.to_h

    # .group_by { |name| name[:location]}

  end

  def find_by_name(name)
    @districts_by_name[name.upcase]
    # # recieves a String
    # returns either nil or an instance of District having done a case insensitive search
  end

  def find_all_matching(fragment)
    @districts_by_name.keys.each do |name|
      if name.include?("ACAD")
        puts name
      else
        []
      end
    end
    # recieves a String
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    # make sure to downcase
  end



  def self.from_csv(path)
    # recieves a String
    # returns a DistrictRepository
    filename  = 'Students qualifying for free or reduced price lunch.csv'
    fullpath  = File.join path, filename
    repo_data = CSV.read(fullpath, headers: true, header_converters: :symbol).map(&:to_h)
    # .map { |row| {row.fetch(:location) => Hash[row.fetch(:poverty_level), Hash[row.fetch(:timeframe), Hash[row.fetch(:dataformat), row.fetch(:data)]]]}}

    DistrictRepository.new(repo_data)
  end

  # def free_or_reduced_lunch
  #   a = {:free_or_reduced_lunch => file_data}
  #   binding.pry
  # end

end







# {|column| Hash[column.fetch(:location), Hash[column.fetch(:timeframe), Hash[column.fetch(:dataformat), column.fetch(:data)]]] }.map(&:to_h)
# data = districts_by_name.map do |row|
#   row.values_at("Colorado")
# end




# def data
#   {"Colorado" => {2000 => 0.020,
#                 2001 => 0.024,
            #    2002 => 0.027,
            #    2003 => 0.030,
            #    2004 => 0.034,
            #    2005 => 0.058,
            #    2006 => 0.041,
            #    2007 => 0.050,
            #    2008 => 0.061,
            #    2009 => 0.070,
            #    2010 => 0.079,
            #    2011 => 0.084,
            #    2012 => 0.125,
            #    2013 => 0.091,
            #    2014 => 0.087,
#  }}
# end

# if @memorized_districts[district] ||=
#   @memorized_districts[district]
# else @memorized_districts[district] =
#   @memorized_districts.find { |district| district.name == name}
# end
# @memorized_districts
