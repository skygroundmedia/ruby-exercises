#Find out the Current Time
t = Time.now

#Find out the Month, Day, or Year individually
puts t.mon.to_s + "/" + t.day.to_s + "/" + t.year.to_s

#Find out the UTC
puts t.utc

###########################
#User Formatted Characters
###########################
#the String For Time function allows you to mix text with data
puts t.strftime("The Document print data is %m/%d/%Y")

#Another way to Display the Month Day, Year
puts t.strftime("%b %d, %Y")