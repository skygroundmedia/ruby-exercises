=begin
Title: Playlist creator CSV to JSON
Date Modified: 10/28/11

Description: 
SoundSnips a.1 for iOS currently requires two types of models: Playlists and individual SoundSnips.
This script parses a CSV file and creates a playlist full of songs.  One of the key/value pairs
will contain the URL the actual SoundSnips themselves.
=end



require 'date'
require 'rubygems'
#sudo gem install excelsior
#sudo gem update excelsior
require 'excelsior'

PLAYLIST_NAME = "resting"
DOMAIN        = "http://media.soundsnips.org/"

def read_csv( file )
  rows = Array.new
  Excelsior::Reader.rows( File.open( file , 'r') ) do |row|
    rows << row
  end
  return rows
end

def generate_json( array )
  date = Date.today.to_s
  output = File.new( PLAYLIST_NAME + "-" + date.to_s + ".json", "w")
  ##
  # Data Pertinent to JSON file
  ##
  server_url = DOMAIN + "data/playlists/" + PLAYLIST_NAME + "/"
  track_url  = DOMAIN + "vod/playlists/" + PLAYLIST_NAME + "/"
  playlist = ''
  src      = ''
  composer = ''
  title    = ''

  #Start Object
  output.puts "{\n\t\"tracklist\": ["
  
  array.length.times do |i|
    if i > 1 
      #new Object + order
      output.puts '{'
      
       #Playlist
       if !array[i][0].nil? 
         d = array[i][0]
         output.puts '"album" :' + "\"#{d}\","
       end

       #File Name
       if !array[i][2].nil? 
         src = array[i][2]
         output.puts '"m3uURL" : ' + "\"#{track_url}#{src}\"," 
       end
       
       #Composer
       if !array[i][3].nil? 
         d = array[i][3]
         output.puts '"composer" : ' + "\"#{d}\"," 
       end 
       
       #Title
       if !array[i][4].nil? 
         d = array[i][4]
         output.puts '"title" : ' + "\"#{d}\"," 
       end      
       
      #Performer
       if !array[i][5].nil? 
         d = array[i][5]
         output.puts '"performer" : ' + "\"#{d}\"," 
       end           
       
       #Icon URL
       output.puts '"iconURL" : ' + '"",'
       
       #SoundSNips URL
       snips = "#{src}".split(".")[0]
       #server_url + track_name.json
       output.puts '"soundsnipURL" : ' + "\"#{server_url}#{snips}.json\","

       #Song Order or ID
       if !array[i][1].nil? 
         d = array[i][1]
         output.puts '"id" : ' + "\"#{d}\""
        #Backup Plan incase we forget to add an order
        else
         output.puts '"id" : ' +"\"#{(i-1).to_s}\""
       end
        
      #End the Object
      output.puts "},"
    end
  end
  #End the JSON
  output.puts "\n\t ],\n\t\"hitcount\": #{array.length-2}\n}"
end

rows = read_csv( "soundsnipsfinal.csv");
generate_json( rows  );
