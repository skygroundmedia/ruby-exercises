=begin
  This needs a whole lot of work and well, little by little I'll keep turning this beast into an Object Oriented project.
  To Do: 
    Make this more OOP driven so that I can get rid of all of this hard-coded JSON formatting.  
=end

class Track
  attr_accessor :id, :tags, :track_url, :composer_first, :composer_last, :composer, :title, :performer, :artwork_large, :property
  
  #This iterates through each column of every row.  This is called by 
  def initialize( array, i )
    track_url  = Feed::Config.media_url
    @property = %Q{\t\t\{ }
    
    column_title = Feed::Config.column_index
                
    #Song Order or ID
    if !array[i][ column_title["song_id"] ].nil? 
      #Make it an integer
      d = array[i][ column_title["song_id"] ].to_i
      converted_integer_to_single_digit = sprintf("%01d", d)
      @property += %Q{ \n\t\t "id" : #{converted_integer_to_single_digit}, }
     #Backup Plan incase we forget to add an order
     else
      @property += %Q{ \n\t\t "id" : #{ (i-1).to_s }, }
    end

    #Tags
     if !array[i][ column_title["tags"] ].nil?
       d = array[i][ column_title["tags"] ].prepare_double_quotes.downcase
       @property += %Q{ \n\t\t "tags" : ["#{d}"], }       
     end
         
     #File Name
     if !array[i][ column_title["track_url"] ].nil? 
       src = array[i][ column_title["track_url"] ].prepare_double_quotes
       @property += %Q{ \n\t\t "src" : "#{track_url}#{src}", }
     end

     #Composer First
     if !array[i][ column_title["composer_first"] ].nil? 
       d = array[i][ column_title["composer_first"] ].prepare_double_quotes
       @composer_first = d
       @property += %Q{ \n\t\t "composer_first" : "#{d}", }
     end 

     #Composer Last
     if !array[i][ column_title["composer_last"] ].nil? 
       d = array[i][ column_title["composer_last"] ].prepare_double_quotes
       @composer_last = d
       @property += %Q{ \n\t\t "composer_last" : "#{d}", }
     end 

     #Piece them together for now to keep our Android Dev happy
     if !@composer_first.nil? && !@composer_last.nil?
       d = @composer_first + " " + @composer_last
       @property += %Q{ \n\t\t "composer" : "#{d}", }
     end      

     #Title
     if !array[i][ column_title["title"] ].nil? 
       d = array[i][ column_title["title"] ].prepare_double_quotes
       @property += %Q{ \n\t\t "title" : "#{d}", }
     end      

    #Performer
     if !array[i][ column_title["performer"] ].nil? 
       d = array[i][ column_title["performer"] ].prepare_double_quotes
       @property += %Q{ \n\t\t "performer" : "#{d}", }
     end

     #Artwork (Large)
     if !array[i][ column_title["artwork_large"] ].nil? 
       #Path from CSV
       file_only = array[i][ column_title["artwork_large"] ]
       #Rip / out / the / path / and / only / keep / the / file / name
       arr = file_only.split("/")
       #The last bit in the array is the filename
       d =  arr.last
       d = Feed::Config.server_url + arr.last
       @property += %Q{ \n\t\t "icon_large" : "#{d}", }
       #Android (Temporary)
       d = d.gsub( "ios", "android")
       @property += %Q{ \n\t\t "icon_large_android" : "#{d}", }       
     elsif
       #iOS
       d = Feed::Config.artwork_default_ios
       @property += %Q{ \n\t\t "icon_large" : "#{d}", }
       #Android
       d = Feed::Config.artwork_default_android
       @property += %Q{ \n\t\t "icon_large_android" : "#{d}", }       
     end

     #SoundSNips URL
     snips = "#{src}".split(".")[0]
     
     @property += %Q{ \n\t\t "soundsnips" : [ }

       #Parse Columns
       @columns = Feed::Config.column_timecode.zip( Feed::Config.column_soundsnip )
       @columns.length.times do |j|

         #Capture the Time
         column_cue_point = 0
         if !array[i][ @columns[j][ column_cue_point ] ].nil? 
           #The CSV file shows that the timecode is placed in certain columns
           timecode = array[i][ @columns[j][ column_cue_point ] ]
           cue_point = Timecode.convert_timecode_into_seconds( "#{timecode}" )
         end
         
         #Use this intentional error to signal the writing team the need for an updat
         if "#{cue_point}".empty?
           cue_point = "-1"
         end

         #Capture the Text
         column_text = 1 
         if !array[i][@columns[j][ column_text ]].nil? 
           text = array[i][@columns[j][ column_text ]].prepare_double_quotes
         end         
         #Sherwin Requested that we make this a Number instead of a string
         @property += %Q{ \n\t\t\t\{ "cue_point" : #{cue_point}, }
         @property += %Q{ "text" : "#{text}" \} }
         @property += "," unless ( j == (@columns.length - 1)  )
       end

     @property += %Q{ ] }

     @property += %Q{ \n\t\t\}, }
     
     #This is how I am converting the object to a String.  
     self.property = @property
  end
  
end