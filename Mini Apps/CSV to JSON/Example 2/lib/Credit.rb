class Credit
	
	attr_accessor :time_of_day
	attr_accessor :url
	attr_accessor :author
	
	def initialize(csv_row)
		@time_of_day = csv_row[:group]
		@url         = csv_row[:url]
		@author      = csv_row[:photographer]
	end
end

