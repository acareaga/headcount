require 'csv'
require 'pry'

class DistrictRepository

  attr_reader :district, :districts_by_name

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
    @districts_by_name.select { |name, district_data| name.include?(fragment.upcase) }
    # recieves a String
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end

  def self.from_csv(path)
    # kicks off distric repo & inits parser
    # enters file_loader and reads file
    # need to connect repo data with methods above
    FileParser.new(path).file_loader
  end

  def self.from_csv(path)

    file1  = '3rd grade students scoring proficient or above on the CSAP_TCAP.csv'
    fullpath  = File.join path, file1
    repo_data_1 = CSV.read(fullpath, headers: true, header_converters: :symbol).map(&:to_h)
    district_data_1 = repo_data_1.group_by { |name, grade| name[:location] + " - Grade 3"}.to_h

    file2 = '8th grade students scoring proficient or above on the CSAP_TCAP.csv'
    fullpath  = File.join path, file2
    repo_data_2 = CSV.read(fullpath, headers: true, header_converters: :symbol).map(&:to_h)
    district_data_2 = repo_data_2.group_by { |name, grade| name[:location] + " - Grade 8"}.to_h

    districts_data = district_data_1.zip(district_data_2)
    # districts_data = repo_data.group_by { |name| name[:location]}

    DistrictRepository.new(districts_data)

  end

  # def self.from_csv(path)
  #   filename  = '3rd grade students scoring proficient or above on the CSAP_TCAP.csv'
  #   fullpath  = File.join path, filename
  #   repo_data = CSV.read(fullpath, headers: true, header_converters: :symbol).map(&:to_h)
  #   districts_data = repo_data.group_by { |name| name[:location]}
  #   DistrictRepository.new(districts_data)
  # end
end

# if @memorized_districts[district] ||=
#   @memorized_districts[district]
# else @memorized_districts[district] =
#   @memorized_districts.find { |district| district.name == name}
# end
# @memorized_districts
