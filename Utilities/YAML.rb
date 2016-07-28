require 'yaml'

class Util
	@@names = %w[chris sandy josie billy suzie]
	
	def to_yaml
		@@names.to_yaml
	end
	
	def to_yaml_through_dump
		YAML::dump(@@names)
	end
	
	def to_array
		YAML::load( to_yaml_through_dump )
	end
	
	def array_iterate
		to_array.length.times do |i|
		  puts i.to_s + " " + to_array[i]
		end
	end
end

util = Util.new

puts util.to_yaml
puts util.to_yaml_through_dump
puts util.to_array
puts util.array_iterate