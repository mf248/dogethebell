describe "Shibe pages" do

  describe "signup page" do
    before { visit signup_path }

    it "should have the content 'Signup'" do
    	expect(page).to have_content('Sign up')
    end

    it "Should have the title Sign Up" do
    	expect(page).to have_title('Sign up')
    end
  end
 end
