require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  # let(:user) { create(:user) }
  # let(:no_activation_user) { create(:no_activation_user) }

# userが追加されたか
  describe "GET /signup" do
    it "is invalid signup information" do
      get signup_path
      expect {
        post signup_path, params: {
          user: {
            name: "",
            email: "user@invalid",
            password: "foo",
            password_confirmation: "bar"
          }
        }
      }.not_to change(User, :count)
      expect(request.fullpath).to eq '/signup'
    end

    it "is valid signup information" do
      get signup_path
      expect {
        post signup_path, params: {
          user: {
            name: "Test Test",
            email: "test@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      }.to change(User, :count).by(1)
      expect(is_logged_in?).to be_falsey
      follow_redirect!
      expect(request.fullpath).to eq '/'
      expect(flash[:info]).to be_truthy
    end
  end
end
