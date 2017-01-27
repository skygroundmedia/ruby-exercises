# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Facility
#
class Facility
    
  def initialize
    # Holds the person currently using the facility
    @occupier = nil
    # How long the facility has been used by the current occupier
    @duration = 0
  end  
  
  # Checks whether the facility is occudied and assigns a person if it isnt
  def occupy(person)
    unless occupied?
      # The person in the queue is now the occupier
      @occupier = person
      # The Duration is increased by 1 minute
      @duration = 1
      # One less person is in the queue
      Person.population.delete Person
      true
    else
      false
    end
  end
  
  def occupied?
    not @occupier.nil?
  end
  
  # Release the person to the general office
  def vacate
    Person.population << @occupier
    @occupier = nil
  end
  
  # Each tick is a minute of time in the real world
  def tick
    if occupied? and @duration > @occupier.use_duration
      vacate
      @duration = 0
    elsif occupied?
      @duration += 1
    end
  end
end