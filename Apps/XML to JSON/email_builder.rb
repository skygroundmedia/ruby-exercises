#!/usr/bin/env ruby

require "faker"
require 'nokogiri'
require File.join(File.dirname(__FILE__), 'lib', 'file_manager')

class EmailUtil
  include FileManager
  
  NUM_OF_EMAILS = 5000
  FILE_PATH     = "emails-#{Date.today.to_s}.xml"

  def initialize
    xml = create_xml
    save(xml, FILE_PATH)
  end
  
  # http://stackoverflow.com/a/27065613
  def create_xml
    builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
      xml.data {

        NUM_OF_EMAILS.times do
          first_name = Faker::Name.first_name
          last_name  = Faker::Name.last_name
          
          xml.option(
          # This represents a message data tag with an optional full name
          %{#{Faker::Internet.email} (#{['', first_name + " " + last_name].sample})},
          first_name:   ['', first_name].sample,
          last_name:    ['', last_name].sample,
          zip_code:     ['', Faker::Address.zip_code].sample,
          gender:       ["m", "f", "o"].sample,
          dob:          Faker::Date.between(Date.parse("1st Jan 1920"), Date.parse("1st Jan #{min_age_requirement}")),
          phone_mobile: ['', Faker::PhoneNumber.cell_phone].sample,
          phone_other:  ['', Faker::PhoneNumber.phone_number].sample
          )
        end
        
      }
    end
    builder.to_xml
  end

  private 
      
  def min_age_requirement
    this_year = Time.now.year
    min_age   = 13
    this_year - min_age
  end  
end

EmailUtil.new
