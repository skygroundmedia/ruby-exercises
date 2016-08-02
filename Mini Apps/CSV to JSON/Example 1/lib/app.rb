# Title: Playlist creator CSV to JSON
# Date Modified: 02/28/12
# 
# Description: 
# SoundSNips will have one master JSON file highlighting all the playlists and their associations [playlist name, mp3 src file, album art, etc]


DATA_DIR = Pathname.new(File.join(APP_ROOT, 'output'))

require 'date'
require 'excelsior'
require 'neatjson'

require_relative 'excelsior_util'

class App
	attr_reader   :input_file
	attr_reader   :playlist_categories

	class Config
	  def self.dir
	    Pathname.new(File.join(APP_ROOT, 'data'))
	  end
	end

=begin
  class Config
    
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
=end
    
  def initialize
		@playlist_categories = ["dining", "driving", "exercising", "resting", "studying", "traveling"]
		
		@playlist_categories.each_with_index do |category, index|
			input_file  = App::Config.dir.join("csv", %Q{#{category}.csv} )
			
			playlist = parse(input_file)
			
			#TODO
			# Create a Playlist Object
			# Create a Soundsnip Object
			# Create a Track Object
			
			file_name = create_json_filename(category)
			
			save(file_name, playlist)
		end
  end	
	
	def parse(file)
    util = ExcelsiorUtil.new(file)
		rows = util.parse
		clean_rows = rows.reject { |row| row[:file_name].nil? }
	end
	
	def create_json_filename(category)
		%Q{playlist-#{category}-#{Date.today.to_s}.json}
	end
	
	def save(file_name, array)
    begin
			#Make the JSON look very pretty 
			json_neat = JSON.neat_generate(array)
			
			#Write to file
			output_file = App::Config.dir.join("json", file_name)
			File.open(output_file, 'w') { |file| file.write(json_neat) }
			
    rescue Exception => e
			puts %Q{Error: #{e}}
    end	
	end
end