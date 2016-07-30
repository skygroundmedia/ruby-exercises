require 'rubygems'
require 'json'

class Reporting
  
  INPUT_FILE = "TimeZones.json"
  
  def initialize
    read_and_parse
  end
  
  def read_and_parse
    file = File.open(INPUT_FILE, 'r').read
    json = JSON.parse(file)
    group_data(json["results"])
  end
  
  def group_data(json)
		#This will group the data by key
		downloads_by_timezone = json.group_by do |timeZone|
			timeZone["timeZone"]
		end		
		publish_data(downloads_by_timezone)
  end  
	
	#Spell out the Key / Value pairs
	def publish_data(data)
		puts %Q{\n\nMethod #1 ––––––––––––––––––––––––––\n\n}
		data.each_pair { |key,value| puts %Q{ #{key}: #{value.count} }}
		
		
		puts %Q{\n\nMethod #2 ––––––––––––––––––––––––––\n\n}
		count_by_timezone = data.map do |timezone,download|
			[timezone, download.size]
		end				
		puts %Q{\n\n #{count_by_timezone} \n\n}
		
		
		puts %Q{\n\nMethod #3 ––––––––––––––––––––––––––\n\n}
		keys = data.keys
		puts %Q{ There are #{keys.count} keys }
		puts %Q{ The first key is "#{keys.first}" }
		puts %Q{ "#{keys.first}" has #{data[keys.first].count} downloads  }
	end
end

Reporting.new