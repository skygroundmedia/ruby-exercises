=begin
Title: Snips Parser CSV to JSON (iOS)
Date Modified: 10/28/2011
Notes: This file 
=end

require 'date'
require 'rubygems'
#sudo gem install excelsior
#sudo gem update excelsior
require 'excelsior'

CSV_FILE = "../soundsnipsfinal.csv"

def read_csv( file )
  rows = Array.new
  Excelsior::Reader.rows( File.open( file , 'r') ) do |row|
    rows << row
  end
  return rows
end

def generate_json( array )
  @date = Date.today.to_s
  
  ##
  # Data Pertinent to JSON file
  ##

  #If you look at the Excel spreadsheet, there's a pattern Carly uses 
  #for her columns. [ time of snip, text of snip ]. I've simply written
  #the index of the column to strip out the data
  snips = [ [6,7], [11,12], [16,17], [21,22], [26,27], [31,32], [36,37], [41,42] ]
  
  #Start parsing each Excel row
  array.length.times do |i|
    
    if i > 1
      #This will be the new file name based on the name of the mp3
      @file_name = "#{array[i][2]}"
      
      #Create a new file for each snippet of info      
      @output = File.new( "#{@file_name.gsub(".mp3", "")}" + ".json", "w")      
      
      #Start the JSON Object
      @output.puts %Q{\{
          "src" : "#{@file_name}",
          "soundsniplist" : [ 
      }
      #The time and text of the snips have been picked from the CSV file
      snips.length.times do |j|
        @output.puts "{"
        
        #Run through each row, and look at the specific rows
        #Capture the Time
        if !array[i][snips[j][0]].nil? 
          d = array[i][snips[j][0]]
          #TODO: Fix this stupid thing called secondgroup
#          @output.puts '"secondgroup" : ' + "#{d}" + ','
          @output.puts %Q{"secondgroup" : #{j+1} , }
        end

        #Capture the Text
        #%-#{d}-
        if !array[i][snips[j][1]].nil? 
          #Strip the mysterious double/double quotes
          d = array[i][snips[j][1]].gsub('""', '"')
          #Replace any Single Quotes with Double Quotes
          d = d.gsub("'", '"')
          #Escape the Double Quotes
          d = d.gsub('"', '\"')
          #http://www.tutorialspoint.com/ruby/ruby_strings.htm
          @output.puts %Q{"textlist" : [ "#{d}" ] }
        end        
        
        #puts i.to_s + ":" + (array.length - 1).to_s + "\t" + j.to_s + ":" + (snips.length-1).to_s
        
        @output.puts "}"
        
        #If this is the last object in the JSON array, don't put a ","
        @output.puts "," unless ( j == (snips.length - 1)  )

      end
      #End the JSON Object
      @output.puts %Q{ \n]\t\n\} }
      
      puts @output.inspect
      
    end
  end
end

rows = read_csv( CSV_FILE );
generate_json( rows  );
