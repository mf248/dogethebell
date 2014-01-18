require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Doge the Bell'" do
      visit '/static_pages/home'
      expect(page).to have_content('Doge the Bell')
    end

    it "should have the right title" do
    	visit '/static_pages/home'
    	expect(page).to have_title('Doge the Bell | Home')
    end
  end

  describe "FAQ" do
  	it "Should have the content 'Frequently Asked Questions'" do
  		visit '/static_pages/faq'
  		expect(page).to have_content('Frequently Asked Questions')
  	end

  	it "Should have the right title" do
  		visit '/static_pages/faq'
  		expect(page).to have_title('Doge the Bell | FAQ')
  	end
  end
end
