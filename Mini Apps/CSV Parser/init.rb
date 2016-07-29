APP_ROOT = File.dirname(__FILE__)

# require "#{APP_ROOT}/lib/guide"
# require File.join(APP_ROOT, 'lib', 'guide.rb')
# require File.join(APP_ROOT, 'lib', 'guide')

$:.unshift( File.join(APP_ROOT, 'lib') )

require 'geo'

csv = File.join(APP_ROOT, 'data', "geo_data.csv")
geo = Geo.new
rows = geo.read_csv(csv)

#Grab the first rown in the array and present it as a Hash
puts %Q{ #{rows.first} }
