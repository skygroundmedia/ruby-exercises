#Strip the mysterious double/double quotes + 
# squeeze removes any extra spaces between words 
# and strip removes leading and trailing spaces

module CoreExtensions
  module String
		module DoubleQuotes
		  #Strip the mysterious double/double quotes + squeeze removes any extra spaces between words and strip removes leading and trailing spaces
		  def prepare_double_quotes
		    self.gsub('""', '"').gsub('"', '\"').squeeze(" ").strip
		  #!!! Temporary
		    #self.gsub('""', '"').gsub('"', '"')
		  end  
		end
	end
end

