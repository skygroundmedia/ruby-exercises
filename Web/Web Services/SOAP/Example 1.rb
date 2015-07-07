#Include the Library
require 'soap/wsdlDriver'
#Tell Ruby where to get he SOAP definition
wsdl = 'http://www.boyzoid.com/comp/randomQuote.cfc?wsdl'
#Initialize the Driver
driver = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
puts driver.getAllQuotes