#Validating that the Credit Card information before you Submit

#
# Download Libraries First
# sudo gem install creditcard
#

#Checksum Digit, there is an algorithm that checksum must match
#A. Import the libraries
require 'rubygems'
require 'creditcard'

#B. Boolean test as to whether this number is a valid credit card
puts '5276 4400 6542 1319'.creditcard?
puts '5276 4400 6542 1319'.creditcard_type