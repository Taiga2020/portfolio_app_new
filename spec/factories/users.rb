FactoryBot.define do

  factory :user do
    name { "Michael Example" }
    email { "michael@example.com" }
    # sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
    activated { true }
  end

  factory :test_user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    activated { true }
  end

  factory :other_user, class: User do
    name { "Sterling Archer" }
    email { "duchess@example.gov" }
    password { "foobar" }
    password_confirmation { "foobar" }
    activated { true }
  end

  factory :no_activation_user, class: User do
    name { "No Activation" }
    email { "no@activation.co.jp" }
    password { "foobar" }
    password_confirmation { "foobar" }
    activated { false }
  end

end
