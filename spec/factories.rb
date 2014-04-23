FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@colorado.edu"
    password "foobar"
    password_confirmation "foobar"
  end
  factory :event do
    title "Rspec Test Event"
    user
  end
end