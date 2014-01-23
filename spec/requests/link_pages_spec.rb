require 'spec_helper'

describe "Link pages" do

  subject { page }

  let(:shibe) { FactoryGirl.create(:shibe) }
  before { sign_in shibe }

  describe "link creation" do
    before { visit shibe_path(shibe) }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Link, :count)
      end

    end

    describe "with valid information" do

      before { fill_in 'link_title', with: "Lorem ipsum" }
      before { fill_in 'link_address', with: "google.com" }
      it "should create a link" do
        expect { click_button "Post" }.to change(Link, :count).by(1)
      end
    end
  end
end
