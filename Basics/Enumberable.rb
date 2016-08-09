#Long Hand

module Enumerable
	#Determine if an existing item should be within a subset
	def subset
		collection = []
		each do |item|
			collection << item if yield(item)
		end
		collection
	end
end	

with_zip_codes = locations.subset do |location|
	location.zip_code unless location.zip_code.nil?
end


# Short Hand

with_zip_codes = locations.select do |location|
	location.zip_code unless location.zip_code.nil?
end
