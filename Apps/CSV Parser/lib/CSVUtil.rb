# Description
# 'csv' has gotten faster over time but it's still slow
# compared to excelsior. That said, if you can wait,
# CSV has a lot of neat features including:
# http://ruby-doc.org/stdlib-2.3.0/libdoc/csv/rdoc/CSV.html

require 'csv'

class CSVUtil
	def read(file)
		CSV.read(file, headers: true, header_converters: :symbol, skip_blanks: true)		
	end
	
	#This example simply iterates through each item one-by-one
	def read_each(file)
		CSV.foreach(file, headers: true, header_converters: :symbol, skip_blanks: true) do |row|
			#guard	
			break if $. > 5
			puts row
		end				
	end
end
