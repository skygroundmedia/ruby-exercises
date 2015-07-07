class Playlist

  attr_accessor :json

  #This creates a playlist object { "resting": [{},{},{},{},{},{},{},{},{},{},] }
  def initialize( array, index, file_name )
    date = Date.today.to_s
    file_name = File.new( Feed::Config.output_dir_json + file_name + ".json", "w")
    individual_playlist_file = file_name

    #We're doing both an iterative and associative array the goal of 
    column_playlist = nil

    @output = %Q{ [\n }
      @output = ""

      array.each_with_index do |data, i|
        #Let's make sure we don't count the column names on the spreadsheet
        if i > Feed::Config.starting_row
          #data = name of the playlist
          name_of_playlist = data[ Feed::Config.column_index["tags"] ]

          #Carly's Spreadsheet will sometimes have info that's not pertinent to SoundSnip data so we need to make sure that doesn't get processed
          if !name_of_playlist.nil?
            #Keep track when the playlist name changes so that we can create new json objects
            if column_playlist != name_of_playlist
              #Populate the playlist name
              column_playlist = name_of_playlist
              #Create the Playlist Object
              @output += %Q{\{ "playlist_name" : "#{name_of_playlist}\",\n }
              @output += %Q{   "playlist_icon_android" : "#{Feed::Config.icons_playlist_android[index]}\",\n }
              @output += %Q{   "playlist_icon_ios"     : "#{Feed::Config.icons_playlist_ios[index]}\",\n }
              @output += %Q{   "tracks\"      : [\n }
              #Run through the CSV file and grab the data that only pertains to this playlist
              array.each_with_index do |content, j|
                puts name_of_playlist
                if !content[ Feed::Config.column_index["tags"] ].nil? && j > Feed::Config.starting_row
                  #Create a JSON object
                  @output +=  Track.new( array, j ).property
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

      self.json = @output.gsub(/\n/, "").gsub(/\t/, "").gsub("},]", "}]").gsub("}, ]", "}]").gsub("},  ]", "}]")
      return self.json
    end

  end