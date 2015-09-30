require './lib/district'
require './lib/district_repository'
require './lib/enrollment'
require './lib/economic_profile'
require './lib/statewide_testing'

class HeadCountAnalyst

### FLOATS ####################
  class Float
    def inspect
      '%.3f' % self
    end
  end

  def truncate(percentage)
    (percentage.to_f * 1000).to_i / 1000
  end
####################

end
