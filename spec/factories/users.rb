FactoryBot.define do

  factory :user do
    # sequence(:no) { |n| n }

    # trait :a do
    name { "Michael Example" }
    email { "michael@example.com" }
    # sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }

    # factory :admin do
      admin { true }
    # end
  end
  # end

  # 他人
  factory :test_user, class: User do
  # trait :b do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
  end

    # trait :c do
    #   name { "Sterling Archer" }
    #   email { "duchess@example.gov" }
    #   password { "foobar" }
    #   password_confirmation { "foobar" }
    # end
  factory :other_user, class: User do
    name { "Sterling Archer" }
    email { "duchess@example.gov" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
  # end

  # sequence :test_users_name do |i|
  #   "Test#{i} User"
  # end
  #
  # sequence :test_users_email do |i|
  #   "test#{i}@example.com"
  # end

  # factory :test_users, class: User do
  #   name { generate :test_users_title }
  #   email { generate :test_users_email }
  #   password { "password" }
  #   password_confirmation { "password" }
  # end

  # factory :test_user do
  #   name { Faker::Name.name }
  #   email { Faker::Internet.email }
  #   password { "password" }
  #   password_confirmation { "password" }
  # end

  # factory :other_user, class: User do
  #   name { "Sterling Archer" }
  #   email { "duchess@example.gov" }
  #   password { "foobar" }
  #   password_confirmation { "foobar" }
  # end
end
