APP_ROOT = File.dirname(__FILE__)
$:.unshift(File.join(APP_ROOT))

test_all = %Q{ bundle exec rspec }
test_one = %Q{ bundle exec rspec }

#Run the App
exec(test_all)
