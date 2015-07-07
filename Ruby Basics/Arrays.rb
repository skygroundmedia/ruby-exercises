names = %w[chris sandy josie billy suzie]

#How to iterate through an array 
names.length.times do |i|
  puts i.to_s + " " + names[i]
end