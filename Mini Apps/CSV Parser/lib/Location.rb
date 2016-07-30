class Location
	attr_accessor :zip_code, 
	:lat, 
	:lng, 
	:city, 
	:state, 
	:county,
	:type
	
	def initialize(csv_row)
		@zip_code = csv_row[:zip_code].to_i
		@lat      = csv_row[:lat]
		@lng      = csv_row[:lng]
		@city     = csv_row[:city]
		@state    = csv_row[:state]
		@county   = csv_row[:county]
		@type     = csv_row[:type]
	end
	
	def city?
		city == "Los Angleles"
	end
end