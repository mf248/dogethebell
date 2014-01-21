describe "Shibe pages" do

  subject { page }

  describe "index" do
    before do
      FactoryGirl.create(:shibe, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:shibe, name: "Ben", email: "ben@example.com")
      visit shibes_path
    end

    it { should have_title('Stats') }
    it { should have_content('Stats') }

    it "should list each shibe" do
      Shibe.all.each do |shibe|
        expect(page).to have_selector('li', text: shibe.name)
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }
  end

  describe "profile page" do
  	let(:shibe) { FactoryGirl.create(:shibe) }
  	before { visit shibe_path(shibe) }

  	it { should have_content(shibe.name) }
  	it { should have_title(shibe.name) }
  end

  describe "signup page" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a shibe" do
        expect { click_button submit }.not_to change(Shibe, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example Shibe"
        fill_in "Email",        with: "shibe@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a shibe" do
        expect { click_button submit }.to change(Shibe, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:shibe) { Shibe.find_by(email: 'shibe@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(shibe.name) }
        it { should have_selector('div.alert.alert-success', text: 'Such Welcome.') }
      end
    end
  end

  describe "edit" do
    let(:shibe) { FactoryGirl.create(:shibe) }
    before do
    	sign_in shibe
    	visit edit_shibe_path(shibe) 
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit shibe") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: shibe.password
        fill_in "Confirm Password", with: shibe.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(shibe.reload.name).to  eq new_name }
      specify { expect(shibe.reload.email).to eq new_email }
    end
  end
end

