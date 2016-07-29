APP_ROOT = File.dirname(__FILE__)
$:.unshift( File.join(APP_ROOT, 'lib') )

file = File.join(APP_ROOT, 'data', "geo_data.csv")

require 'ExcelsiorUtil'
ecsv = ExcelsiorUtil.new
rows = ecsv.read(file)
puts %Q{ #{rows.last} }


puts %Q{ \n\n~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n }


require 'CSVUtil'
csv = CSVUtil.new
rows = csv.read(file)
puts %Q{ #{rows.first.inspect} \n\n }
puts %Q{ :zip_code #{rows.first[:zip_code]} }
