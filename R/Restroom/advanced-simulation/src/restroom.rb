# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Restroom
#
class Restroom
  # People waiting to enter the restroom
  attr_reader :queue
  # List of facilities (urinals, etc)
  attr_reader :facilities
  
  def initialize(facilities_per_restroom=3)
    @queue = []
    @facilities = []
    facilities_per_restroom.times { @facilities << Facility.new }
  end
  
  # Looks for the next available facility and lets the person occupy it
  def enter(person)
    unoccupied_facility = @facilities.find { |facility| not facility.occupied? }
    if unoccupied_facility
      unoccupied_facility.occupy person
    # Or if places the person in the queue
    else
      @queue << person
    end
  end
  
  # This is how we count down time
  def tick
    @facilities.each { |f| f.tick }
  end
end