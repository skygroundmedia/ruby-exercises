APP_ROOT = File.dirname(__FILE__)
$:.unshift( File.join(APP_ROOT, '..', 'lib') )

require 'minitest/autorun'
require 'CSVUtil'
require 'Location'

class LocationTest < MiniTest::Test
	def setup
		@location = Location.new({
			:zip_code => "99950",
			:lat => "+55.542007",
			:lng => "-131.432682",
			:city => "KETCHIKAN",
			:state => "AK",
			:county => "KETCHIKAN GATEWAY",
			:uniqueness => "STANDARD"
		})
	end
	
	def test_city?
		assert_equal false, @location.city?
		@location.city = "Los Angleles"
		assert_equal true, @location.city?
	end
	
	def test_zip_code
		assert_equal "99950", @location.zip_code
	end
	
	def test_lat
		assert_equal "+55.542007", @location.lat
	end
	
	def test_lng
		assert_equal "-131.432682", @location.lng
	end
	
end