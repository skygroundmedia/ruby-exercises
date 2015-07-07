=begin
Title: Playlist creator CSV to JSON
Date Modified: 02/28/12

Description: 
SoundSNips will have one master JSON file highlighting all the playlists and their associations [playlist name, mp3 src file, album art, etc]
=end

require 'date'
#require 'json'
require 'rubygems'
#sudo gem install excelsior
#sudo gem update excelsior
require 'excelsior'
#sudo gem install timecode
#require 'Timecode'
require 'support/timecode_extend'
require 'support/string_extend'

require 'playlist'
require 'track'
require 'soundsnip'

class Feed
  
  class Config
    @@output_dir = "./output/"
    def self.output_dir_json; @@output_dir + "json/"; end
    def self.output_dir_csv;  @@output_dir + "csv/";  end
    
    #Server URL Paths#####################################################
    #Don't worry, in track.rb, I automatically switch out "ios" for "android"
    @@server_url = "http://artwork-ios.soundsnips.org/"
    def self.server_url; @@server_url; end
    
    @@static_url = "http://soundsnips.jit.su/static/images/"
    def self.static_url; @@static_url; end
        
    @@media_url = "http://stream.soundsnips.org/vod/audio/"
    def self.media_url; @@media_url; end
    
    #Playlist Categories#####################################################
    @@categories = ["dining", "driving", "exercising", "resting", "studying", "traveling"]
    def self.categories; @@categories; end    
    
    #Artwork Images#####################################################
    @@artwork_default_ios = "http://artwork-ios.soundsnips.org/640x640.png"
    def self.artwork_default_ios; @@artwork_default_ios; end
    
    @@artwork_default_android = "http://artwork-android.soundsnips.org/480x480.png"
    def self.artwork_default_android; @@artwork_default_android; end
    
    #XSLS Spreadsheets#####################################################
    #Carly's spreadsheet has column names on row 1 so let's skip over them    
    @@starting_row = 1
    def self.starting_row; @@starting_row; end    
    
    # Playlist Icons#######################################################
    @@icons_playlist_ios = Array.new
    def self.icons_playlist_ios; @@icons_playlist_ios; end
    
    @@icons_playlist_android = Array.new
    def self.icons_playlist_android; @@icons_playlist_android; end
    
    @@categories.each do |data|
      #Build iOS Icons
      url = @@static_url + "icons/playlists/ios/" + data + ".png"
      @@icons_playlist_ios.push( url )
      #Build Android Icons
      url = @@static_url + "icons/playlists/android/" + data + ".png"      
      @@icons_playlist_android.push( url )
    end
    
    #Timecode + SoundSnips Columns########################################
    #If you look at the Excel spreadsheet, there's a pattern Carly uses 
    #for her columns. [ time of snip, text of snip ]. I've simply written
    #the index of the column to strip out the data
    @@column_timecode = [ 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61 ]
    def self.column_timecode; @@column_timecode; end
    @@column_soundsnip = [ 12, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62 ]
    def self.column_soundsnip; @@column_soundsnip; end
    
    @@column_index = { "song_id" => 1, "tags" => 0, "track_url" => 2, "composer_first" => 3, 
                      "composer_last" => 4, "title" => 5, "performer" => 6, "artwork_large" =>  10 }
    def self.column_index; @@column_index; end
  end
    
  def initialize(path=nil)
    #Create the Master Playlist File Name
    date = Date.today.to_s
    file_name = Feed::Config.output_dir_json + "playlist" + "-" + date.to_s + ".json"    
    output = File.new( file_name, "w")
    
    #Starting JSON Array
    output.puts %Q{[\n }    
    
    #Master JSON file known as "playlist.json"
    Feed::Config.categories.each_with_index do |category, index|
      rows = read_csv( get_csv_path( category ) );
      output.puts Playlist.new( rows, index, category  ).json;
      #For each playlist object, make sure it is seperated by an ","
      output.puts "," unless ( index == (Feed::Config.categories.size - 1)  )
    end
    #Ending JSON Array
    output.puts %Q{ ] }
    
    puts "\nPublished to playlist_builder/output/json/"
    puts "!!! Don't forget to validate http://jsonlint.com "
  end
  
  #CSV File Path + Reader Stuff
  def get_csv_path(category)
    Feed::Config.output_dir_csv + category + ".csv"
  end  

  def read_csv( file )
    rows = Array.new
    Excelsior::Reader.rows( File.open( file , 'r') ) do |row|
      rows << row
    end
    return rows
  end

end