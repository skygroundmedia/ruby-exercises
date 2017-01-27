require 'date'
require 'json'
require 'active_support/json'
require 'rubygems'
require "rexml/document"

require File.join(File.dirname(__FILE__), 'lib', 'file_manager')

class List
  include FileManager

  FILE_XML  = "output/emails-#{Date.today.to_s}.xml"
  FILE_JSON = "output/emails-#{Date.today.to_s}.json" 
  
  def initialize(input=FILE_XML)
    if !input.empty?
      file = load(input)
      json = parse(file)
      save(json, FILE_JSON)
    elsif ARGV.empty?
      puts "Please add an XML filepath"
      puts "For example: ruby init.rb './path/to/file.xml'"
      exit
    else
      ARGV.each_with_index do|a, idx|
        if idx == 0
          load(a)
        end
      end
    end
  end
  
  def parse(file)
    #Create a new Rolodex
    contacts  = Array.new
    #Convert the file to become XML-ready
    doc = REXML::Document.new(file)
    #Iterate through each node
    doc.elements.each_with_index("data/option") { |e, idx| 
      my_text = e.text
      #Capture the email before "("
      before_char = my_text[/[^(]+/]
      #Capture the text after "("
      after_char = my_text[/\(.*/m]

      arr   = my_text.split("(")
      email = arr[0].strip!
      name  = arr[1][/[^)]+/] ? arr[1][/[^)]+/].strip : ""
      
      contacts.push({
        "email": email, 
        "full_name": name,
        "first_name":   e.attributes["first_name"],
        "last_name":    e.attributes["last_name"],
        "zip_code":     e.attributes["zip_code"],
        "gender":       e.attributes["gender"],
        "dob":          e.attributes["dob"],
        "phone_mobile": e.attributes["phone_mobile"],
        "phone_other":  e.attributes["phone_other"]
      })      
    }
    json = ActiveSupport::JSON.encode(contacts)
  end  
end

List.new
