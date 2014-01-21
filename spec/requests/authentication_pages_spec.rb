require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end


    end

    describe "with valid information" do
      let(:shibe) { FactoryGirl.create(:shibe) }
      before do
        fill_in "Email",    with: shibe.email.upcase
        fill_in "Password", with: shibe.password
        click_button "Sign in"
      end

      it { should have_title(shibe.name) }
      it { should have_link('Profile',     href: shibe_path(shibe)) }
      it { should have_link('Settings',    href: edit_shibe_path(shibe)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end  
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:shibe) { FactoryGirl.create(:shibe) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_shibe_path(shibe)
          fill_in "Email",    with: shibe.email
          fill_in "Password", with: shibe.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit shibe')
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_shibe_path(shibe) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch shibe_path(shibe) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
    describe "as wrong shibe" do
      let(:shibe) { FactoryGirl.create(:shibe) }
      let(:wrong_shibe) { FactoryGirl.create(:shibe, email: "wrong@example.com") }
      before { sign_in shibe, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_shibe_path(wrong_shibe) }
        specify { expect(response.body).not_to match('Edit shibe') }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Shibes#update action" do
        before { patch shibe_path(wrong_shibe) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end
