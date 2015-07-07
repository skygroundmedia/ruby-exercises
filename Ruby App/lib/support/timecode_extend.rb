require 'Timecode'

class Timecode
  #http://rubydoc.info/gems/timecode/1.1.0/Timecode
  def self.convert_timecode_into_seconds( string )    
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
end