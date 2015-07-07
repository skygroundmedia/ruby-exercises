##########################
#XML-RPC (Remote Procedure Calls)
##########################
#Example 1: Find a State in a Specific Sort Order
#A. Import the XMLPRC Library (Thanx Michael Nuemann)
require 'xmlrpc/client'
#B. You have to define the web address that will run the RPC against
server = XMLRPC::Client.new2('http://betty.userland.com/RPC2')
puts server.call('examples.getStateName', 1)

#Example 2: Find product information based on a UPC number
#C. You have to define the web address that will run the RPC against
server = XMLRPC::Client.new2('http://dev.upcdatabase.com/rpc')
#D. lookupUPC is a method 
@item = server.call('lookupUPC', '720642442524')
#E. Store the result in an array
p @item
puts "Description :: " + @item["description"]
puts "Type        :: " + @item["size"]
