#Web 2.0 Generator
5.times do

letters = { ?v => 'aeiou', ?c => 'bcdfghjklmnpqrstvwxyz'}
#p letters
word = ""
i = 0
'cvcvc'.each_byte do |x|
  #puts x
  source = letters[x]
  #<< concatenates or appends
  word << source[rand(source.length)].chr
end

puts word + '.com'

require 'open-uri'
open("http://whois.net/whois_new.cgi?d=" + word + "&tld=com") {|f|
  @req = f.read
  #puts @req
  #Return the 1st position where the string is matched
  @txt = @req.index("No match")
  #puts @txt
  if @txt.nil?
    puts "Domain is available"
  else
    puts "Sorry - Domain is taken"
  end
    
  }
end