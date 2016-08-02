#### CSV to JSON Converter ####
#
# Launch this Ruby file from the command line 
# to get started.
#

require 'csv'
require 'active_support/JSON'
require 'neatjson'
require 'pathname'

APP_ROOT  = File.dirname(__FILE__)
PATH_NAME = Pathname.new(File.join(APP_ROOT, 'lib'))

require_relative PATH_NAME.join('Credit')

class App 
	attr_accessor :input_file, :output_file
	
	class Config
	  def self.dir
	    Pathname.new(File.join(APP_ROOT, 'data'))
	  end
	end
	
	def initialize(csv_file, json_file)
		@input_file  = App::Config.dir.join("csv", csv_file)
		@output_file = App::Config.dir.join("json", json_file)
	end

	def parse
		#Parse the CSV file into an array of rows
		csv_rows = CSV.read(@input_file, headers: true, header_converters: :symbol, skip_blanks: true)
		#Remove any rows that have blank url cells (http://stackoverflow.com/a/20650397)
		csv_rows_cleaned = csv_rows.reject { |row| row.to_hash[:url].blank? }
		#Send the data to get grouped and organized
		organize(csv_rows_cleaned)
	end
	
	def organize(rows)
		#Map the CSV rows to Credit objects so that they have context
		credits = rows.map { |row| Credit.new(row) }
		
		#Group all the photos from the same author
		group_by_author = credits.group_by { |credit| credit.author }
	end

	def save(array)
		#try/catch
    begin
			#Make the JSON look very pretty 
			json_neat = JSON.neat_generate(array)
			#Write to file
			File.open(@output_file, 'w') { |f| f.write(json_neat) }
			#Send success message
			message(%Q{Your JSON is ready. \n The file can be found => #{@output_file}})
    rescue Exception => e
			message(%Q{Error: #{e}})
    end
	end
	
	def message(msg)
		puts %Q{~~~~~~~~\n\n#{msg}\n\n~~~~~~~~~}
	end
end

csv  = "App Background Photos.csv"
json = %Q{credits_#{Date.today.to_s}_1.json}


app  = App.new(csv, json)
results = app.parse
app.save(results)
