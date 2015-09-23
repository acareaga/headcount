require 'csv'  # => true
require 'pry'  # => true

class DistrictRepository

  attr_reader :district, :repo_data

  def initialize(repo_data)
    @repo_data = repo_data
  end                       # => nil

  def find_by_name(district_name)
    @districts = repo_data.map { |row| [row.fetch(:location), row.fetch(:data)] }.to_h
    @districts[district_name]
    binding.pry
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
  end                                                               # => :find_by_name

  def find_all_matching(fragment)
    # recieves a String
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    # make sure to downcase
  end                              # => :find_all_matching

  def economic_profile
    free_or_reduced_lunch_in_year
    # collection of data sets for each district
    # move to class eventually
  end                   # => :economic_profile

  def free_or_reduced_lunch_in_year(year)

  end

  def self.from_csv(path)
    # recieves a String
    # returns a DistrictRepository
    filename  = 'Students qualifying for free or reduced price lunch.csv'
    fullpath  = File.join path, filename
    repo_data = CSV.read(fullpath, headers: true, header_converters: :symbol).map(&:to_h)
    DistrictRepository.new(repo_data)
  end            # => :from_csv
end              # => :from_csv

Hash[:key, "value"]                # => {:key=>"value"}
Hash[:key, Hash[:key2, "value"]]   # => {:key=>{:key2=>"value"}}
[["a",1], ["b",2], ["c", 3]].to_h  # => {"a"=>1, "b"=>2, "c"=>3}
