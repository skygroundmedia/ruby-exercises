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

class Playlist
  FILE_CSV = "../soundsnipsfinal102811.csv"
  FILE_NAME = "playlist"
  DOMAIN        = "http://media.soundsnips.org/"
  ROW_TO_START_COUNTING = 1
  
  def initialize
    rows = read_csv( FILE_CSV );
    generate_json( rows  );
  end

  def read_csv( file )
    rows = Array.new
    Excelsior::Reader.rows( File.open( file , 'r') ) do |row|
      rows << row
    end
    return rows
  end
  
  def create_json_object( array, i )
    server_url = DOMAIN + "data/soundsnips/"
    track_url  = DOMAIN + "vod/playlists/"
    
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
     @property += %Q{ \n\t\t "icon_small" : "http://media.soundsnips.org/data/album_art/30x30.png", }
     @property += %Q{ \n\t\t "icon_large" : "http://media.soundsnips.org/data/album_art/500x500.png", }

     #SoundSNips URL
     snips = "#{src}".split(".")[0]
     #server_url + track_name.json
     @property += %Q{ \n\t\t "soundsnip_url" : "#{server_url}#{snips}.json" }
     
     @property += %Q{ \n\t\t\}, }
     
     return @property
  end

  def generate_json( array )
    date = Date.today.to_s
    output = File.new( FILE_NAME + "-" + date.to_s + ".json", "w")
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

Playlist.new