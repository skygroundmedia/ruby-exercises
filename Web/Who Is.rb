5.times do 

letters = { ?v => 'aeiou', ?c => 'bcdfghjklmnpqrstvwxyz'}
word = ''

'cvcv'.each_byte do |x|
  source = letters[x]
  word << source[rand(source.length)].chr
end

puts word + ".com"

require 'open-uri'
open("http://whois.net/whois_new.cgi?d=" + word + "&tld=com"){ 
  |f|
  #Get the Full response which should be the full HTML
  @req = f.read
  #Find the first place where "No match is found", if nothing is found, it will return 'nil'
  #puts @req
  
  @txt = @req.index("No match")
  #puts @txt
  
  if @txt.nil?
    puts "Domain " + word + ".com is available"
  else
    puts "Domain " + word + ".com is taken"
  end
}

end