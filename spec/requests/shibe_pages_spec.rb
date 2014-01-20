describe "Shibe pages" do

  subject { page }

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
    end
  end
end

