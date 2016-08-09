require 'fileutils'
require 'date'
require 'rubygems'
require 'json'

class Reporting
  
  INPUT_FILE = "TimeZones.json"
  
  def initialize
    read_file
  end
  
  def read_file
    file = File.open(INPUT_FILE, 'r').read
    json = JSON.parse(file)
    parse(json)
  end
  
  def parse(json)
    #A list of countries
    countries  = {}
    #Iterate throught the JSON file
    json["results"].each_with_index do |row|
      #try/catch
      begin
        key = row["timeZone"]
        if countries[key].nil?
          #Add a new Country
          countries.store(key, 1)
        else
          #Add a count to the country
          current_count = countries[key]
          countries[key] = add(current_count)
        end
      rescue Exception => e
        puts %Q{ "Error: " + #{e} }
      end
    end
    publish(countries)
  end
  
  def publish(hash)
    hash.each do |k,v|
      puts %Q{#{k}:#{v}}
    end
  end
  
  private
  
  def add(number)
    number.next
  end  
end

Reporting.new
