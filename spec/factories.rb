FactoryGirl.define do
  factory :shibe do
    name     "VandyILL"
    email    "mfergus48@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :link do
  	title "google"
  	address "google.com"
  	shibe
  end
end
