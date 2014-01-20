require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
  	before { visit root_path}

    it "should have the content 'Doge the Bell'" do
      expect(page).to have_content('Doge the Bell')
    end

    it "should have the right title" do
    	expect(page).to have_title('Doge the Bell | Home')
    end
  end

  describe "FAQ" do
  	before { visit faq_path}

  	it "Should have the content 'Frequently Asked Questions'" do
  		expect(page).to have_content('Frequently Asked Questions')
  	end

  	it "Should have the right title" do
  		expect(page).to have_title('Doge the Bell | FAQ')
  	end
  end

  describe "Contact page" do
  	before { visit contact_path }

    it "should have the content 'Contact'" do
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      expect(page).to have_title("Doge the Bell | Contact")
    end
  end

  
end
