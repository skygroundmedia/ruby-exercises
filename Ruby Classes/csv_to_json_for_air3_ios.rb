=begin
Title: Playlist creator CSV to JSON
Date Modified: 10/31/11

Description: 
SoundSNips will have one master JSON file highlighting all the playlists and their associations [playlist name, mp3 src file, album art, etc]
=end

require 'date'
require 'rubygems'
#sudo gem install excelsior
#sudo gem update excelsior
require 'excelsior'
#sudo gem install timecode
require 'Timecode'

class Playlist
   
  CATEGORIES = ["dining", "driving", "exercising", "resting", "studying", "traveling"]

  OUTPUT_DIR = "../final/json/"
  DOMAIN        = "http://stream.soundsnips.org/playlists/"

  ROW_TO_START_COUNTING = 1
  #If you look at the Excel spreadsheet, there's a pattern Carly uses 
  #for her columns. [ time of snip, text of snip ]. I've simply written
  #the index of the column to strip out the data
  COLUMN_TIMECODE  = [ 6, 11, 16, 21, 26, 31, 36, 41 ]
  COLUMN_SOUNDSNIP = [ 7, 12, 17, 22, 27, 32, 37, 42 ]
  
  @file_name = nil
  
  def initialize( )
    #Iterate through each category and compile a JSON file
    CATEGORIES.each do |category|
      @file_csv = "../final/csv/" + category + ".csv"
      @file_name = category
      rows = read_csv( @file_csv );
      generate_json( rows  );
    end
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
  
  def create_json_object( array, i )
    server_url = DOMAIN + "data/soundsnips/"
    track_url  = DOMAIN
    
    @property = %Q{\t\t\{ }
    
    #Song Order or ID
    if !array[i][1].nil? 
      d = array[i][1]
      @property += %Q{ \n\t\t "id" : "#{d}", }
     #Backup Plan incase we forget to add an order
     else
      @property += %Q{ \n\t\t "id" : "#{(i-1).to_s}", }
    end

    #Playlist Again (Just IN case)
     if !array[i][0].nil? 
       playlist = array[i][0].prepare_double_quotes.downcase
       @property += %Q{ \n\t\t "playlist" : "#{playlist}", }
     end
         
     #File Name
     if !array[i][2].nil? 
       src = array[i][2].prepare_double_quotes
       @property += %Q{ \n\t\t "src" : "#{track_url}#{playlist}/#{src}", }
     end

     #Composer
     if !array[i][3].nil? 
       d = array[i][3].prepare_double_quotes
       @property += %Q{ \n\t\t "composer" : "#{d}", }
     end 

     #Title
     if !array[i][4].nil? 
       d = array[i][4].prepare_double_quotes
       @property += %Q{ \n\t\t "title" : "#{d}", }
     end      

    #Performer
     if !array[i][5].nil? 
       d = array[i][5].prepare_double_quotes
       @property += %Q{ \n\t\t "performer" : "#{d}", }
     end

     #Icon URL
     @property += %Q{ \n\t\t "icon_small" : "http://soundsnips.djangozoom.net/images/artwork/30x30.png", }
     @property += %Q{ \n\t\t "icon_large" : "http://soundsnips.djangozoom.net/images/artwork/500x500.png", }

     #SoundSNips URL
     snips = "#{src}".split(".")[0]
     #server_url + track_name.json
     @property += %Q{ \n\t\t "soundsnips" : [ }

       #Parse Columns
       @columns = COLUMN_TIMECODE.zip( COLUMN_SOUNDSNIP )
       @columns.length.times do |j|

         #Capture the Time
         if !array[i][ @columns[j][0] ].nil? 
           #The CSV file shows that the timecode is placed in certain columns
           timecode = array[i][ @columns[j][0] ]
           cue_point = convert_timecode_into_seconds( "#{timecode}" )
         end
         
         #Use this intentional error to signal the writing team the need for an updat
         if "#{cue_point}".empty?
           cue_point = "-1"
         end

         #Capture the Text
         if !array[i][@columns[j][1]].nil? 
           text = array[i][@columns[j][1]].prepare_double_quotes
         end         
         
         @property += %Q{ \n\t\t\t\{ "cue_point" : #{cue_point}, }
         @property += %Q{ "text" : "#{text}" \} }

         @property += "," unless ( j == (@columns.length - 1)  )
       end
    @property += %Q{ ] }  
     
     @property += %Q{ \n\t\t\}, }
     
     return @property
  end

  def generate_json( array )
    date = Date.today.to_s
    #Includes Date
    #output = File.new( OUTPUT_DIR + @file_name + "-" + date.to_s + ".json", "w")
    output = File.new( OUTPUT_DIR + @file_name + ".json", "w")
    playlist = ''

    #@output.puts += %Q{ "#{soundsnip.file_name}-#{index}" : \{ \n}
        
    @output = %Q{[\n }
                
    array.length.times do |i|
      if i > ROW_TO_START_COUNTING 
         #Playlist
         if !array[i][0].nil? 
           d = array[i][0]
           if playlist != d.to_s
             #Populate the playlist name
             playlist = d
              #Create the Playlist Object
             @output += %Q{\{ "#{d}\" : [\n}
             #Highly Inefficient, needs improvement
            #Run through teh CSV file and grab the data that only pertains to this playlist
              array.length.times do |index|
                if playlist == array[index][0] && index > ROW_TO_START_COUNTING
                  #Create a JSON object
                  @output +=  create_json_object( array, index )
                end
              end
            #Close the Playlist Object
             @output += %Q{ \n\t\t] \n\},\n }
           end
         end

      end
    end
    #End the JSON
    @output += %Q{] }
    #View the data
    puts @output
    #Hack: Remove \t, \n, remove this stupid trailing apostrophy, then print
    output.puts @output.gsub(/\n/, "").gsub(/\t/, "").gsub("},]", "}]").gsub("}, ]", "}]").gsub("},  ]", "}]")
    
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


Playlist.new