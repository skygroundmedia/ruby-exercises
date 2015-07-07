=begin
This helper is opening up the core Ruby String class in order to add a new method to al Strings
=end

class String
  
  #Strip the mysterious double/double quotes + squeeze removes any extra spaces between words and strip removes leading and trailing spaces
  def prepare_double_quotes
    self.gsub('""', '"').gsub('"', '\"').squeeze(" ").strip
  #!!! Temporary
    #self.gsub('""', '"').gsub('"', '"')
  end  
  
end
