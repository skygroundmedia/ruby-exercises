# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Person
#
class Person
  DURATION = 540
  # Class var that stores the entire population of the simulation
  @@population = []
  # Describes how long a person takes to use the facility
  attr_reader :use_duration
  # Describes how many times th person will use the facility over the duration of the simulation
  attr_reader :frequency
  
  def initialize(frequency=4, use_duration=1)
    @frequency    = frequency
    @use_duration = use_duration
  end  
  
  def self.population
    @@population
  end
  
  # What is the probability of the person needing to go at this point in time?
  def need_to_go?
    # The prrobability is 3 times over the span of 540 mins. 3/540
    rand(DURATION) + 1 <= @frequency
  end
end