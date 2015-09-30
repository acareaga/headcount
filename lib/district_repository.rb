require 'csv'
require 'pry'
require_relative 'file_parser'
require_relative 'district'

class DistrictRepository

  attr_reader :district, :districts_by_name, :name

  def initialize(districts_data)
    @districts_by_name = districts_data.map { |name, district_data|
      [name.upcase, District.new(name, district_data)]
    }.to_h
  end

  def find_by_name(name)
    @districts_by_name[name.upcase]
    # # recieves a String
    # returns either nil or an instance of District having done a case insensitive search
  end

  def find_all_matching(fragment)
    @districts_by_name.select { |name, district_data| name.include?(fragment.upcase) }.keys
    # recieves a String
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end

  def self.from_csv(path) # FINAL GOAL -- DONT DELETE
    # kicks off distric repo & inits parser
    # enters file_loader and reads file
    # need to connect repo data with methods above
    districts_data = FileParser.new(path).file_loader
    DistrictRepository.new(districts_data)
  end
end

# if @memorized_districts[district] ||=
#   @memorized_districts[district]
# else @memorized_districts[district] =
#   @memorized_districts.find { |district| district.name == name}
# end
# @memorized_districts
