#### CSV to JSON Converter ####
#
# Launch this Ruby file from the command line 
# to get started.
#

require 'pathname'

APP_ROOT  = File.dirname(__FILE__)
PATH_NAME = Pathname.new(File.join(APP_ROOT, 'lib'))

require_relative PATH_NAME.join('App')

app = App.new