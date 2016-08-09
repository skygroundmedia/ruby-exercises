#find / detect returns an Object or nil, it will not find all the numbers
puts "\n" + "#find returns an Object or nil"
puts (1..10).find { |i| i == 5 }

puts "\n" + "detect returns an Object or nil. Note:It only returns the first example."
puts (1..10).detect { |i| i % 3 == 0 }
puts "\n" + "detect can be used to determine which other numbers are within a range"
puts (1..10).detect { |i| (1..10).include?(i * 3) }


#find_all / select returns an Array 
puts "\n" + "find_all returns an Array"
puts (1..10).find_all { |i| i % 3 == 0 }

puts "\n" + "select returns an Array.  Three numbers can be multiplied by 3 and still not exceed 10."
puts (1..10).select { |i| (1..10).include?(i * 3) }

# Method any? returns a Boolean
puts "\n" + "any? returns a Boolean.  In other words, are there any in the set that are true?"
puts (1..10).any?  { |i| i % 3 == 0 }

# Method all? returns a Boolean
puts "\n" + "all? returns a Boolean.  Do all the conditions meet the requirement?"
puts (1..10).all?  { |i| i % 3 == 0 }

# Method delete_if? returns an Array.
puts "\n" + "delete_if anything is divisible by 3"
puts [*1..10].delete_if { |i| i % 3 == 0 }


#Merge

#Collect

#Sort

#Inject

