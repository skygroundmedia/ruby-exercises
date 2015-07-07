#
# Serve an HTML from the HardDisk
# Viewable at localhost:8888
#

require 'thread'
require 'socket'

class RequestHandler
  def initialize(session)
    @session = session
  end
  def process
    #Wait for all the data to be collected
    while @session.gets.chop.length != 0
    end
    
    #Output HTTP Header content and serve the HTML page
    @session.puts "HTTP/1.1 200 OK"
    @session.puts "content-type: text/html"
    @session.puts ""
    
    #Have Ruby load an entire document right off your drive
    tmpFile = IO.readlines("blank_page.html")
    @session.puts tmpFile
    @session.close
  end
end

#Server a local HTTP Request on Port 8888
server = TCPServer.new("0.0.0.0", "8888")
while(session = server.accept)
  #When a new session request is made, a thread is spun and function process begins
  Thread.new(session) do |newSession|
    RequestHandler.new(newSession).process
  end
end
