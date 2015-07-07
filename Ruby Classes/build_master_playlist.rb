=begin
Title: Playlist creator CSV to JSON
Date Modified: 02/28/12

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

  #Images
  SERVER_URL = "http://soundsnips.djangozoom.net"
  SERVER_IMAGES_URL = SERVER_URL + "/images/"
  IOS_ICONS_PLAYLISTS = [ 
    SERVER_IMAGES_URL + "icons/playlists/ios/dining.png",
    SERVER_IMAGES_URL + "icons/playlists/ios/driving.png",
    SERVER_IMAGES_URL + "icons/playlists/ios/exercising.png",
    SERVER_IMAGES_URL + "icons/playlists/ios/resting.png",
    SERVER_IMAGES_URL + "icons/playlists/ios/studying.png",
    SERVER_URL + "icons/playlists/ios/traveling.png" 
  ]
  ANDROID_ICONS_PLAYLISTS = [ 
    SERVER_IMAGES_URL + "icons/playlists/android/dining.png",
    SERVER_IMAGES_URL + "icons/playlists/android/driving.png",
    SERVER_IMAGES_URL + "icons/playlists/android/exercising.png",
    SERVER_IMAGES_URL + "icons/playlists/android/resting.png",
    SERVER_IMAGES_URL + "icons/playlists/android/studying.png",
    SERVER_IMAGES_URL + "icons/playlists/android/traveling.png" 
  ]

  OUTPUT_DIR    = "../final/json/"
  MEDIA_URL     = "http://stream.soundsnips.org/vod/audio/"
  ALBUM_ARTWORK_DEFAULT_IOS = SERVER_URL + "artwork/ios/640x640.png"
  ALBUM_ARTWORK_DEFAULT_ANDROID = SERVER_URL + "artwork/android/480x480.png"

  #Carly's spreadsheet has column names on row 1 so let's skip over them
  ROW_TO_START_COUNTING = 1
  #If you look at the Excel spreadsheet, there's a pattern Carly uses 
  #for her columns. [ time of snip, text of snip ]. I've simply written
  #the index of the column to strip out the data
  COLUMN_TIMECODE  = [ 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61 ]
  COLUMN_SOUNDSNIP = [ 12, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62 ]
    
  @file_name = nil
  
  def initialize( )
    date = Date.today.to_s
    #output = File.new( OUTPUT_DIR + "playlist" ".json", "w")
    output = File.new( OUTPUT_DIR + "playlist" + "-" + date.to_s + ".json", "w")
    output.puts %Q{[\n }    
    
    #Master JSON file known as "playlist.json"
    CATEGORIES.each_with_index do |category, index|
      @file_csv = "../final/csv/" + category + ".csv"
      @file_name = category
      rows = read_csv( @file_csv );
      output.puts create_playlist_object( rows, index  );
      #For each playlist object, make sure it is seperated by an ","
      output.puts "," unless ( index == (CATEGORIES.size - 1)  )
    end
    output.puts %Q{ ] }
    
    puts "!!! Don't forget to validate this JSON http://jsonlint.com "
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
  
  #This iterates through each column of every row.  This is called by 
  def create_json_object( array, i )
    track_url  = MEDIA_URL
    @property = %Q{\t\t\{ }
    
    #Song Order or ID
    if !array[i][1].nil? 
      d = array[i][1].to_i
      converted_integer_to_single_digit = sprintf("%01d", d)
      @property += %Q{ \n\t\t "id" : #{converted_integer_to_single_digit}, }
     #Backup Plan incase we forget to add an order
     else
      @property += %Q{ \n\t\t "id" : #{(i-1).to_s}, }
    end

    #Tags
     if !array[i][0].nil?
       d = array[i][0].prepare_double_quotes.downcase
       @property += %Q{ \n\t\t "tags" : ["#{d}"], }       
     end
         
     #File Name
     if !array[i][2].nil? 
       src = array[i][2].prepare_double_quotes
       @property += %Q{ \n\t\t "src" : "#{track_url}#{src}", }
     end

     #Composer First
     if !array[i][3].nil? 
       d = array[i][3].prepare_double_quotes
       @composer_first = d
       @property += %Q{ \n\t\t "composer_first" : "#{d}", }
     end 

     #Composer Last
     if !array[i][4].nil? 
       d = array[i][4].prepare_double_quotes
       @composer_last = d
       @property += %Q{ \n\t\t "composer_last" : "#{d}", }
     end 

     #Piece them together for now to keep our Android Dev happy
     if !@composer_first.nil? && !@composer_last.nil?
       d = @composer_first + " " + @composer_last
       @property += %Q{ \n\t\t "composer" : "#{d}", }
     end      

     #Title
     if !array[i][5].nil? 
       d = array[i][5].prepare_double_quotes
       @property += %Q{ \n\t\t "title" : "#{d}", }
     end      

    #Performer
     if !array[i][6].nil? 
       d = array[i][6].prepare_double_quotes
       @property += %Q{ \n\t\t "performer" : "#{d}", }
     end

     #Artwork (Small)
     if !array[i][9].nil?
       d = array[i][9]
       @property += %Q{ \n\t\t "icon_small" : "#{d}", }
     elsif
       d = ALBUM_ARTWORK_DEFAULT
       @property += %Q{ \n\t\t "icon_small" : "#{d}", }
     end
     
     #Artwork (Large)
     if !array[i][10].nil? 
       #iOS
       d = SERVER_URL + array[i][10]
       @property += %Q{ \n\t\t "icon_large" : "#{d}", }
       #Android
       d = ALBUM_ARTWORK_DEFAULT_ANDROID
       @property += %Q{ \n\t\t "icon_large_android" : "#{d}", }
       
     elsif
       #iOS
       d = ALBUM_ARTWORK_DEFAULT_IOS
       @property += %Q{ \n\t\t "icon_large" : "#{d}", }
       #Android
       d = ALBUM_ARTWORK_DEFAULT_ANDROID
       @property += %Q{ \n\t\t "icon_large_android" : "#{d}", }       
     end

     #SoundSNips URL
     snips = "#{src}".split(".")[0]
     
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
         #Sherwin Requested that we make this a Number instead of a string
         @property += %Q{ \n\t\t\t\{ "cue_point" : #{cue_point}, }
         @property += %Q{ "text" : "#{text}" \} }
         @property += "," unless ( j == (@columns.length - 1)  )
       end

     @property += %Q{ ] }

     @property += %Q{ \n\t\t\}, }

     return @property
  end

  #This creates a playlist object { "resting": [{},{},{},{},{},{},{},{},{},{},] }
  def create_playlist_object( array, index )
    date = Date.today.to_s
    individual_playlist_file = File.new( OUTPUT_DIR + @file_name + ".json", "w")
    #individual_playlist_file = File.new( OUTPUT_DIR + @file_name + "-" + date.to_s + ".json", "w")
    
    #We're doing both an iterative and associative array the goal of 
    column_playlist = nil
  
    @output = %Q{ [\n }
    @output = ""

    array.each_with_index do |data, i|
      #Let's make sure we don't count the column names on the spreadsheet
      if i > ROW_TO_START_COUNTING
        #data = name of the playlist
        name_of_playlist = data[0]

        #Carly's Spreadsheet will sometimes have info that's not pertinent to SoundSnip data so we need to make sure that doesn't get processed
        if !name_of_playlist.nil?
          #Keep track when the playlist name changes so that we can create new json objects
          if column_playlist != name_of_playlist
            #Populate the playlist name
            column_playlist = name_of_playlist
            #Create the Playlist Object
            @output += %Q{\{ "playlist_name": "#{name_of_playlist}\",\n }
            @output += %Q{   "playlist_icon_android" : "#{ANDROID_ICONS_PLAYLISTS[index]}\",\n }
            @output += %Q{   "playlist_icon_ios"     : "#{IOS_ICONS_PLAYLISTS[index]}\",\n }
            @output += %Q{   "tracks\"      : [\n }
            #Run through teh CSV file and grab the data that only pertains to this playlist
            array.each_with_index do |content, j|
              puts name_of_playlist
                if !content[0].nil? && j > ROW_TO_START_COUNTING
                  #Create a JSON object
                  @output +=  create_json_object( array, j )
                end
            end
            
            #Close the Playlist Object
             @output += %Q{ \n\t\t] \n\}\n }            
          end
        end
        
      end
    end

    #View the name_of_playlist
#    puts @output
    #Hack: Remove \t, \n, remove this stupid trailing apostrophy, then print
    individual_playlist_file.puts @output.gsub(/\n/, "").gsub(/\t/, "").gsub("},]", "}]").gsub("}, ]", "}]").gsub("},  ]", "}]")
    
    return @output.gsub(/\n/, "").gsub(/\t/, "").gsub("},]", "}]").gsub("}, ]", "}]").gsub("},  ]", "}]")
  end
end

class String
  def prepare_double_quotes
    #Strip the mysterious double/double quotes + squeeze removes any extra spaces between words and strip removes leading and trailing spaces
    self.gsub('""', '"').gsub('"', '\"').squeeze(" ").strip
  #!!! Temporary
    #self.gsub('""', '"').gsub('"', '"')
  end  
end

class SoundSnip
  attr_accessor :file_name, :playlist, :cue_point, :text
end

Playlist.new