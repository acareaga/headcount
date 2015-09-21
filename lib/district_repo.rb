repository = DistrictRepository.from_csv("data")
district = repository.find_by_name("name")
