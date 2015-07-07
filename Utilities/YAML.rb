#A. Importing the YAML Library
require 'yaml'
names = %w[chris sandy josie billy suzie]

#Example 1 : Converting an array into YAML using: to_yaml
yaml_example1 = names.to_yaml
puts yaml_example1

#Example 2: Converting an array into YAML using: dump()
yaml_example2 = YAML::dump(names)
puts yaml_example2

#Example 3: Loading YAML back into an array using: load()
array_example = YAML::load(yamloutput2)
puts array_example

#How to iterate through an array 
array_example.length.times do |i|
  puts i.to_s + " " + array_example[i]
end