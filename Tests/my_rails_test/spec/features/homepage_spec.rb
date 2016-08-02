require 'rails_helper'

feature 'my home page' do
	scenario 'hello world message' do
		visit('/')
		expect(page).to have_content("Hello World!")
	end
	#Use capybar to auto complete forms and navigate
	
end