FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@colorado.edu"
    password "foobar"
    password_confirmation "foobar"
  end
end