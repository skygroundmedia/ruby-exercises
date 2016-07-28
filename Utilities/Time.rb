class TimeUtil
	@t = nil
		
	def initialize
		@t= Time.now
	end
	
	def mm_dd_yy
		#Find out the Month, Day, or Year individually
		puts @t.mon.to_s + "/" + @t.day.to_s + "/" + @t.year.to_s

		#Another way to Display the Month Day, Year
		puts @t.strftime("%b %d, %Y")		
	end
	
	def utc
		#Find out the UTC
		puts @t.utc
	end
	
	def show
		#the String For Time function allows you to mix text with data
		puts @t.strftime("The Document print data is %m/%d/%Y")
	end
end

t = TimeUtil.new
t.mm_dd_yy
t.utc
t.show