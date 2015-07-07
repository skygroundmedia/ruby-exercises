#The Merge method is for Hashes only.  
h1 = { "a" => 111, "b" => 222 }
h2 = { "b" => 333, "c" => 444 }

#Conflict resolution
puts h1.merge(h2) { |key, old_value, new_value| old_value }
puts h1.merge(h2) { |key, old_value, new_value| new_value }


#Longhand
puts h1.merge(h2) do |key, old_value, new_value|
  if old_value < new
    old_value
  else
    new_value
  end
end

#Shorthand
puts h1.merge(h2) { |k, o, n| o < n ? o : n }