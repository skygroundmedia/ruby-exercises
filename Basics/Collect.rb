#Collect is the same as Map

#Collect works best with Arrays, Hashes, and Ranges
array = [ 1, 2, 3, 4, 5 ]

#Iterates through the array, does the proccess and puts everything into a new array
new_array = array.collect { |i| i + 1 }
puts new_array

#You can do the same with an array of Strings
fruits = [ 'apple', 'banana', 'orange' ].map { |fruit| fruit.capitalize }
puts fruits

#Rules of thumb: The number of items in = the number of items out. 2) You will always get an array


fruits2 = [ 'apple', 'banana', 'orange' ].map do |fruit|
  if fruit == 'banana'
    fruit.capitalize
  else
    fruit
  end
end
puts fruits2