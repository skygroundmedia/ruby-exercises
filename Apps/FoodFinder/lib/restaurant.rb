require 'support/number_helper'

class Restaurant
  include NumberHelper

  #Class only variable
  @@filepath = nil  

  #Class Getter
  def self.filepath=(path=nil)
    @@filepath = path
  end
  
  #Instance Getter and Setter
  attr_accessor :name, :cuisine, :price
  
  def self.file_exists?
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
    end
  end
  
  def self.file_usable?
    #1. Within each of these steps, the file might fail
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    #2. If nothing flags fail, then return true
    return true
  end
  
  def self.create_file
    #1. Create the file if it doesn't exist.  If it does exist, just open it and close it
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?
  end
  
  def self.saved_restaurants
    #1. Read the file
    restaurants = []
    #2. return instances of restaurant
    if file_usable?
      file = File.new(@@filepath, 'r')
      
      file.each_line do |line|
        #Create an instance first, then populate it
        restaurants << Restaurant.new.import_line(line.chomp)
      end
      file.close
    end
    return restaurants
  end

  def self.build_from_questions
    args = {}    
    
    print "Restaurant name:"
    args[:name]    = gets.chomp.strip
    
    print "Restaurant type:"
    args[:cuisine] = gets.chomp.strip
    
    print "Restaurant price:"
    args[:price]   = gets.chomp.strip

    return self.new(args)
  end
  
  def initialize(args={})
    @name     = args[:name]    || ""
    @cuisine = args[:cuisine]  || ""
    @price    = args[:price]   || ""    
  end
  
  def import_line(line)
    line_array = line.split("\t")
    #Create an Array an assign it to this oneline array
    @name, @cuisine, @price = line_array
    #Restaraint.new.import_line(line.chomp) is returning an instance
    return self
  end
  
  #This is an instance method so you have to explicitely ask the class for the file_usable
  def save
    return false unless Restaurant.file_usable?
    #Write a new line
    File.open( @@filepath, 'a' ) do |file|
      #name \t cuisine \t price + newline
      file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
    end
    return true
  end
  
  def formatted_price
    number_to_currency(@price)
  end
  
end