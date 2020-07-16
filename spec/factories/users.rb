FactoryBot.define do
  factory :user do
    name { "TestUser1" }
    email { "testuser1@example.com" }
    password { "password" }
  end
end
