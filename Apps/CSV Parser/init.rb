APP_ROOT = File.dirname(__FILE__)
$:.unshift(File.join(APP_ROOT, 'lib'))

@file = File.join(APP_ROOT, 'data', "geo_data.csv")

# Option 1 is all about speed
# Excelsior is super fast
def option_one
	require 'ExcelsiorUtil'
	ecsv = ExcelsiorUtil.new
	rows = ecsv.read(@file)
	puts %Q{ #{rows.last} }
end

# Option 2 is all about elegance
# It's not as fast but that's totally fine

def option_two	
	require 'CSVUtil'
	require 'Location'
	#Create a new CSV Utility Object
	csv = CSVUtil.new
	#Collect an array of CSV Objects
	rows = csv.read(@file)
	#Elegant mapping
	locations = rows.map do |row|
		Location.new(row)
	end
	
	#puts locations.first

	#Filter a collection, only show records that have a zip_code
	with_zip_codes = locations.select do |location|
		location.zip_code unless location.zip_code.nil?
	end
	
	#Aggregating a collection of itmes (like for a ratings score)
	total_zip_code_average = with_zip_codes.reduce(00501) do |total, location|
		#puts $.
		total + location.zip_code
	end
	
	puts total_zip_code_average
	
end


#
# This is simply designed for testing
#
def run_tests
	exec("ruby ./tests/location_test.rb")
end


# You can run functions from the command line
# Examples:
# ruby init.rb run_tests
# ruby init.rb option_one
# ruby init.rb option_two
#eval(ARGV.first)


option_two