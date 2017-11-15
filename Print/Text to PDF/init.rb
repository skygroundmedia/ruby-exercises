APP_ROOT = File.dirname(__FILE__)
$:.unshift(File.join(APP_ROOT, 'assets'))

require 'rubygems'
require 'prawn'
require 'prawn-svg'

@ex1 = File.join(APP_ROOT, 'final', 'test.pdf')
Prawn::Document.generate(@ex1) do
  font File.join('assets', 'dejavu-sans', 'DejaVuSans-Bold.ttf')
  text "this is a test " * 100
end

@ex2 = File.join(APP_ROOT, 'final', 'logo.pdf') 
Prawn::Document.generate(@ex2) do |pdf|
  svg = File.join('assets', 'noun_project_23948.svg')
  pdf.svg File.read( svg ), :at => [300, 300]
  pdf.text_box "goes here", :at => [51, 742]
end