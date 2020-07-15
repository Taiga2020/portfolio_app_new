require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do

  # let(:user) { create(:user) }

  describe "GET /login" do
    it "has a danger flash message because of invalid login information" do
      get login_path
      post login_path, params: {
        session: {
          email: "",
          password: ""
        }
      }
      expect(flash[:danger]).to be_truthy
    end

    # it "has no danger flash message because of valid login information" do
    #   get login_path
    #   post login_path, params: {
    #     sessions: {
    #       email: user.email,
    #       password: user.password
    #     }
    #   }
    #   expect(flash[:danger]).to be_falsey
    # end
  end
end
