class Gameplay
	
	attr_accessor :player #player
	
	def initialize
	end
	
	def pins(rolls)
		
	end
	
	def score
		0
	end
	
	def rolls(player)
		@score
	end
	
end


class Player
	attr_accessor :name #string
	attr_accessor :current_score #array
	attr_accessor :current_round #int
end