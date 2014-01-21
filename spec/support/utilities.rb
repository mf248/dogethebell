def sign_in(shibe, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = Shibe.new_remember_token
    cookies[:remember_token] = remember_token
    shibe.update_attribute(:remember_token, Shibe.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: shibe.email
    fill_in "Password", with: shibe.password
    click_button "Sign in"
  end
end