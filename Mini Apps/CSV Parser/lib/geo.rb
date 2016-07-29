require 'excelsior'

class Geo
  def read_csv(file)
    rows    = Array.new
		column_header = nil
    Excelsior::Reader.rows( File.open( file , 'r') ) do |row|
			#Skip this row if it's empty
			next if row.empty?

			if column_header.nil?
				column_header = row
			else
				#1. zip will combine our header with the row
				#rows << Hash[headers.zip(row)]
				#2. hash will turn our multi-dimensional array into a dictionary	
				rows << Hash[column_header.zip(row)]
			end
		end
		puts rows
		return rows
  end
end