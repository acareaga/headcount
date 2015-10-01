require_relative 'file_parser'
require_relative 'district'
require 'csv'

class DistrictRepository

  attr_reader :district, :districts_by_name, :name

  def initialize(districts_data)
    @districts_by_name = districts_data.map { |name, district_data|
      [name.upcase, District.new(name, district_data)]
    }.to_h
  end

  def find_by_name(name)
    @districts_by_name[name.upcase]
  end

  def find_all_matching(fragment)
    @districts_by_name.select { |name, district_data| name.include?(fragment.upcase) }.keys
  end

  def self.from_csv(path)
    districts_data = FileParser.new(path).file_loader
    DistrictRepository.new(districts_data)
  end
end
