# Description
# So here's the deal, Excelsior is fast. I mean super fast.
# It's so fast it's painful to watch CSV even try to compete.
# But, CSV is built-in and has a lot of neat methods you can 
# use to simplify your life such as auto conversion of column
# names into symbols.
#
# This simplified utility aims to provide a few of the niceties 
# of CSV but with the speed of Excelsior.

require 'excelsior'

class ExcelsiorUtil
	
	attr_accessor :file
		
	def initialize(file)
		@file = file
  end
	
	def parse
    rows    = Array.new
		headers = nil
    Excelsior::Reader.rows( File.open(@file, 'r') ) do |row|
			# If there are blank rows, skip them
			next if row.empty?
			# Assuming the column headers are in row 1
			if headers.nil?
				headers = row.each
			else
				#1. .zip will combine our header with the row
				#rows << Hash[headers.zip(row)]
				#2. Hash will turn our multi-dimensional array into a dictionary
				#3. .symbolize_keys will turn the string into a symbol
				rows << Hash[headers.zip(row)].symbolize_keys
			end
		end
		return rows
	end
	
end

# Convert a string to a symbol
class Hash
  def symbolize_keys
    inject({}) { |result, (key, value)|
      key = key.clean.to_sym if key.respond_to?(:to_sym)
      result[key] = value
      result
    }
  end
end 
 
# Clean up the string
class String
  def clean
    self.gsub(' ', '_').strip.downcase
	end
end