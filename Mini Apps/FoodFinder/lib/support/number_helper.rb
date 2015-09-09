# This module illustrates how additional functionality can be included
# or ("mixed-in") to a class then reused.  Borrows heavily from 
# Ruby on Rails' number_to_currency method.

module NumberHelper
  
  def number_to_currency(number, options={})
    unit      = options[:unit]      || '$'
    precision = options[:precision] || 2
    delimiter = options[:delimiter] || ','
    seperator = options[:separator] || '.'
    
    #Remove the Seperator if we've been told not to use 
    seperator = '' if precision == 0
    #Split it on the decimal (integer half, decimal half)
    integer, decimal = number.to_s.split('.')
    
    #Work backwards every three numbers
    i = integer.length
    until i <= 3
      i -= 3
      integer = integer.insert(i, delimiter)
    end
    
    #If the precision is 0, then there is no decimal
    if precision == 0
      precise_decimal = ''
    #Figure out what that decimal out to be
    else
      #make sure decimal is not nil
      decimal ||= "0"
      #make sure the decimal is not too large, clip
      decimal = decimal[0, precision - 1]
      #make sure the decimal is not too short
      precise_decimal = decimal.ljust(precision, "0")      
    end
    
    return unit + integer + seperator + precise_decimal    
    
  end
  
end
