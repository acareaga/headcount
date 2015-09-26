require 'csv'
require 'pry'

class DistrictRepository

  attr_reader :district, :districts_by_name

  def initialize(repo_data)
    @districts_by_name = repo_data.group_by { |name| name[:location]}
    @districts_by_name.map { |name, district_data|
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
    filename  = 'Students qualifying for free or reduced price lunch.csv'
    fullpath  = File.join path, filename
    repo_data = CSV.read(fullpath, headers: true, header_converters: :symbol).map(&:to_h)

    DistrictRepository.new(repo_data)
  end

end

# if @memorized_districts[district] ||=
#   @memorized_districts[district]
# else @memorized_districts[district] =
#   @memorized_districts.find { |district| district.name == name}
# end
# @memorized_districts
