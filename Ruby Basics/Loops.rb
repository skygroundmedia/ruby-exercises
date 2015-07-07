#
#break = Terminate the whole loop
#next  = Jump to the next loop
#redo  = Redo this loop
#retry = Start the whole loop over
#

x = 0

loop do
  x += 2
  break if x >= 20
  puts x
end

puts "\n"

x = 0

loop do
  x += 2
  break if x >= 20
  next if x == 6
  puts x
end

puts "\n"

x = 0

while x < 20
  x += 2
  puts x
end
   
puts "\n"

#While

x = 0
puts x += 2 while x < 100

puts "\n"

#Until

y = 3245
puts y /= 2 until y <= 1

puts "\n"


#Iterators: You traverse a fixed set of data
5.times do
  puts "Hello"
end

1.upto(5) { puts "hello" }; puts "\n"

5.downto(1) { puts "hello" }; puts "\n"

(1..5).each { puts "hello" }; puts "\n"

1.upto(5) do |i|
  puts "hello" + i.to_s
end  

puts "\n"

fruits = [ 'banana', 'apple', 'pear' ]

fruits.each do |fruit|
  puts fruit.capitalize
end  

for fruit in fruits
  puts fruit.capitalize
end