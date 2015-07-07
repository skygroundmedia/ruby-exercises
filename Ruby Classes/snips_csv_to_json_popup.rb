=begin
Title: Parse SoundSnips CSV to JSON (HTML5)
Date Modified: 10/30/2011
Description: This file parses data and prepares it for a potential HTML5 version of SoundSNips
=end

require 'fileutils'
require 'date'
require 'rubygems'
#sudo gem install excelsior
#sudo gem update excelsior
require 'excelsior'
#sudo gem install timecode
require 'Timecode'

class CSVUtil
  #Get This directory
  APP_ROOT = File.dirname(__FILE__)
  CSV_FILE = "./soundsnipsfinal102811.csv"
  OUTPUT_DIR = "json"
  ROW_TO_START_COUNTING = 1
  
  #If you look at the Excel spreadsheet, there's a pattern Carly uses 
  #for her columns. [ time of snip, text of snip ]. I've simply written
  #the index of the column to strip out the data
  COLUMN_TIMECODE  = [ 7, 12, 17, 22, 27, 32, 37, 42 ]
  COLUMN_SOUNDSNIP = [ 8, 13, 18, 23, 28, 33, 38, 43 ]

  def initialize
    create_output_directory
    #Read the CSV file
    rows = read_csv( CSV_FILE );
    #Create JSON files
    create_json_file( rows  );  
  end 
  
  def create_output_directory
    #Remove any previous JSON Folder
    FileUtils.rm_rf( OUTPUT_DIR )
    #Create a /JSON directory
    Dir.mkdir( OUTPUT_DIR )
    #Make it platform independent
    $:.unshift( File.join(APP_ROOT, OUTPUT_DIR ) )
  end
  
  def read_csv( file )
    rows = Array.new
    Excelsior::Reader.rows( File.open( file , 'r') ) do |row|
      rows << row
    end
    return rows
  end

  #http://rubydoc.info/gems/timecode/1.1.0/Timecode
  def convert_timecode_into_seconds( string )
    #first thigns first, let's convert carly's mins::secs into smpte timecode
    @framerate = 25
    @timecode = string
    #if the timecode is missing a number before minutes, then we need to insert one
    if @timecode[0..1].include? ":"
      @timecode = "0" + @timecode
    end
    # =>       hours + [mins:secs] + frames
    @timecode = "00:" + @timecode + ":00"
    #Convert the timecode into seconds
    seconds = Timecode.parse(@timecode, @framerate).to_seconds
    #Second is a float right now so convert it to a string a strip out that extra float stuff.0
    seconds = seconds.to_s.split(".").first
    return seconds
  end

  def init_json_object_for_html5( soundsnip, index, length)
    #Run through each row, and look at the specific rows
    @margin_offset = 50
    @duration = soundsnip.cue_point.to_i + 3

    @property =  ""
    @property += %Q{ "#{soundsnip.file_name}-#{index}" : \{ \n}
    @property += %Q{    type\t\t: "content", \n}
    @property += %Q{    effect\t\t: "fade", \n}
    @property += %Q{    className\t\t: "bubbles2", \n}
    @property += %Q{    dimensions\t\t: [ $("#video-example").width() - #{@margin_offset} + "px", $("#video-example").height() - #{@margin_offset} + "px" ], \n}
    @property += %Q{    position\t\t: [ "0px", "0px" ], \n}
    @property += %Q{    playlist\t\t: "#{soundsnip.playlist}", \n}
    @property += %Q{    config\t\t\t: [ #{soundsnip.cue_point}, #{@duration} ], \n}
    @property += %Q{    content\t\t\t: "#{soundsnip.text}" \n}
    #Closing Brace
    @property += %Q{ \} }
    #If this is the last object in the JSON array, don't put a ","
    @property += "," unless ( index == (length - 1)  )

    return @property
  end

  #Data Pertinent to JSON file
  def create_json_file( data )
    @date = Date.today.to_s

    #Parse Row
    data.length.times do |i|

      if i > ROW_TO_START_COUNTING
        
        #Initialize SoundSnips
        soundsnip = SoundSnip.new
        #This will be the new file name based on the name of the mp3
        soundsnip.file_name = "#{ data[i][2] }".gsub(".mp3", "")
        #Found in the fist column of the CSV file
        soundsnip.playlist = data[i][0]        
        soundsnip.cue_point = -1

        #Create a new file for each snippet of info      
        @output = File.new( "./" + OUTPUT_DIR + "/" + "#{soundsnip.file_name}" + ".json", "w")

        #Start the JSON Object
        @output.puts %Q{ jsonCallBack( \{ }

        #Parse Columns
        @columns = COLUMN_TIMECODE.zip( COLUMN_SOUNDSNIP )
        @columns.length.times do |j|
          
          #Capture the Time
          if !data[i][ @columns[j][0] ].nil? 
            #The CSV file shows that the timecode is placed in certain columns
            timecode = data[i][ @columns[j][0] ]
            cue_point = convert_timecode_into_seconds( "#{timecode}" )
            soundsnip.cue_point = cue_point
          end

          #Capture the Text
          if !data[i][@columns[j][1]].nil? 
            text = data[i][@columns[j][1]].prepare_double_quotes
            soundsnip.text = text
          end

          #puts data[i][0] + " : " + j.to_s + " : " + timecode + " : " + soundsnip

          #Write the JSON object the file
          @output.puts init_json_object_for_html5( soundsnip, j, @columns.length )
        end

        #End the JSON Object
        @output.puts %Q{ \} ); }

        #puts i.to_s + " : " + @output.inspect
      end
    end
  end
end

class String
  def prepare_double_quotes
    #Strip the mysterious double/double quotes
    self.gsub('""', '"').gsub('"', '\"')
  end  
end

class SoundSnip
  attr_accessor :file_name, :playlist, :cue_point, :text
end

CSVUtil.new()