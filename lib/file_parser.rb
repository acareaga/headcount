require './lib/district_repository'
require 'csv'
require 'pry'

class FileParser

  attr_reader :filename

  def initialize(filename)

    # recieves a String
    # returns a DistrictRepository
    # .map { |row| {row.fetch(:location) => Hash[row.fetch(:poverty_level), Hash[row.fetch(:timeframe), Hash[row.fetch(:dataformat), row.fetch(:data)]]]}}
  end

  def self.from_csv(path)
    filename  = 'Students qualifying for free or reduced price lunch.csv'
    fullpath  = File.join path, filename
    repo_data = CSV.read(fullpath, headers: true, header_converters: :symbol).map(&:to_h)

    DistrictRepository.new(repo_data)
  end

  def parse_free_or_reduced_lunch
    filename  = 'Students qualifying for free or reduced price lunch.csv'
    a = {:free_or_reduced_lunch => file_data}
    binding.pry
  end

end

# {|column| Hash[column.fetch(:location), Hash[column.fetch(:timeframe), Hash[column.fetch(:dataformat), column.fetch(:data)]]] }.map(&:to_h)
# data = districts_by_name.map do |row|
#   row.values_at("Colorado")
# end
