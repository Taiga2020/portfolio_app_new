require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
# userが追加されたか
  describe "GET /signup" do
    it "is invalid signup information" do
      get signup_path
      expect {
        post users_path, params: {
          user: {
            name: "",
            email: "user@invalid",
            password: "foo",
            password_confirmation: "bar"
          }
        }
      }.not_to change(User, :count)
    end
  end
end
