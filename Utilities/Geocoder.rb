#http://jonathanvingiano.com/area/
require 'area'

ZIP_CODE = "90015"

puts %Q{ #{ZIP_CODE.to_region}, #{ZIP_CODE.to_latlon}, #{ZIP_CODE.to_gmt_offset} }




require 'rubygems'
require 'geokit'
geo = Geokit::Geocoders::GoogleGeocoder.geocode(ZIP_CODE)
if geo.success
	puts %Q{ #{geo.state}, #{geo.city}, #{geo.ll} }
end