require 'restaurant'
require 'support/string_extend'

class Guide
  
  class Config
    @@actions = [ 'list', 'find', 'add', 'quit' ]
    def self.actions; @@actions; end
  end
  

  def initialize(path=nil)
    #1. Locate the restaurant text file at path
    Restaurant.filepath = path;
    if Restaurant.file_usable?
      puts "Found restaurant file."
    #2. Create a new file
    elsif Restaurant.create_file
      puts "Created restaurante file."
    #3. Exit if create fails
    else
      puts "Exiting.\n\n"
      exit!
    end
  end
  
  def launch!
    introduction
    #action_loop
=begin
    #1. Version 1
    loop do
      print "> "
      #  what do you want to do? (list, find, add, quit)
      user_response = gets.chomp
      #Do the action and return a :symbol
      result = do_action( user_response )
      #If the result that comes back is "quit", then break the loop
      break if result == :quit
    end
=end
    #1. Version 2
    result = nil
    until result == :quit
      action, args = get_action
      #Do the action and return a :symbol
      result = do_action( action, args )
    end

    conclusion
  end
  
  def get_action
    action = nil
    #Keep asking the user (a.k.a loop) input until we get a valid action
    until Guide::Config.actions.include?(action) 
      #Don't load this the first time because action = nil   
      puts "Please choose an actions: " + Guide::Config.actions.join(", ") if action
      print "> "
      #  what do you want to do? (list, find, add, quit)
      user_response = gets.chomp
      #Downcase and strip any whitespace
      args = user_response.downcase.strip.split(' ')
      action = args.shift      
    end
    #Ruby can only return on thing at a time so this is now an array
    return action, args
  end
  
  def do_action(action, args=[])
    case action
    when 'list'
      list(args)
    when 'find'
      keyword = args.shift
      find(keyword)
    when 'add'
      add
    when 'quit'
      return :quit
    else
      puts "\nI don't understand that command"
    end
  end
  
  def list(args=[])
    sort_order = args.shift
    #Set the default and ensure that a user will use :name, :cuisine, or :price
    sort_order = "name" unless ['name', 'cuisine', 'price'].include?(sort_order)
    sort_order = args.shift if sort_order = 'by'
    output_action_header("Listing restaurants")
    
    restaurants = Restaurant.saved_restaurants

    restaurants.sort! do |rest1, rest2|  
      case sort_order        
        when 'name'
          rest1.name.downcase <=> rest2.name.downcase
        when 'cuisine'
          rest1.cuisine.downcase <=> rest2.cuisine.downcase
        when 'price'
          rest1.price.to_i<=> rest2.price.to_i
      end
    end
    
    output_restaurant_table( restaurants )
    puts "Sort using: 'list cuisine' or 'list by cuisine'\n\n"
  end
    
  def add
    output_action_header("Add a restaurant")
    
    restaurant = Restaurant.build_from_questions

    if restaurant.save
      puts "\nRestaurant Added\n\n"
    else
      puts "\nSave Error:\n\n"
    end
  end
  
  def find(keyword="")
    output_action_header("Find a Restaurant");
    
    if keyword
      restaurants = Restaurant.saved_restaurants

      found = restaurants.select do |rest|
        rest.name.downcase.include?(keyword.downcase) || 
        rest.cuisine.downcase.include?(keyword.downcase) || 
        rest.price.to_i <= keyword.to_i
      end
      
      output_restaurant_table(found)
    else
      puts "Find using a key phrase to search the restaurant list."
      puts "Examples: 'find tamale', 'find Mexican', find mex'\n\n"
    end
  end
  
  
  def introduction
    puts "\n\n<<<< Welcome to the Food Finder >>>>\n\n"
    puts "This is an interaactive guide to help you find the food you create.\n\n"
  end
  
  def conclusion
    puts "\n<<<< Goodbye and Buen Provecho! >>>>\n\n\n"
  end
  
  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n".upcase
  end
  
  def output_restaurant_table(restaurants=[])
   print " " + "Name".ljust(30) 
   print " " + "Cuisine".ljust(20) 
   print " " + "Price".rjust(6) + "\n"
   puts "-" * 60
   
   restaurants.each do |rest|
     line = " " << rest.name.titleize.ljust(30)
     line << " " + rest.cuisine.titleize.ljust(20)
     line << " " + rest.formatted_price.rjust(6)
     puts line
   end
   
   puts "No listings found" if restaurants.empty?
   puts "-" * 60
  end
  
end