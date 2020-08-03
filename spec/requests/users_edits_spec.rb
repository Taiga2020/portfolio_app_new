require 'rails_helper'

RSpec.describe "UsersEdits", type: :request do

  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  # before do #userを定義しなくてもよい場合
    # create(:user)
    # create(:test_user)
    # create(:other_user)
  # end

  def patch_invalid_information
    patch user_path(user), params: {
      user: {
        name: "",
        email: "foo@invalid",
        password: "foo",
        password_confirmation: "bar"
      }
    }
  end

  def patch_valid_information
    patch user_path(user), params: {
      user: {
        name: user.name,
        email: user.email,
        password: user.password,
        password_confirmation: "password"
      }
    }
  end

  describe "GET /users/:id/edit" do
    context "invalid" do
      it "does not go to /users/1/edit because of not-login" do
        get edit_user_path(user)
        follow_redirect!
        expect(request.fullpath).to eq '/login'
      end

      it "does not go to /users/2/edit because of login as wrong user" do
        log_in_as(user)
        expect(request.fullpath).to eq '/users/1'
        get edit_user_path(other_user)
        expect(request.fullpath).to eq '/users/2/edit'
        follow_redirect!
        expect(request.fullpath).to eq '/'
      end

      it "does not redirect update because of login as wrong user" do
        log_in_as(user)
        expect(request.fullpath).to eq '/users/1'
        get edit_user_path(other_user)
        expect(request.fullpath).to eq '/users/2/edit'
        follow_redirect!
        expect(request.fullpath).to eq '/'
        patch_valid_information
        # follow_redirect!
        expect(request.fullpath).to eq '/users/1'
      end

      it "is invalid edit information" do
        log_in_as(user)
        expect(is_logged_in?).to be_truthy
        get edit_user_path(user)
        expect(request.fullpath).to eq '/users/1/edit'
        patch_invalid_information
        expect(flash[:danger]).to be_truthy
        expect(request.fullpath).to eq '/users/1'
      end
    end

    context "valid" do
      it "is valid edit information" do
        log_in_as(user)
        expect(is_logged_in?).to be_truthy
        get edit_user_path(user)
        expect(request.fullpath).to eq '/users/1/edit'
        patch_valid_information
        expect(flash[:success]).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/users/1'
      end

      it "shows previous page after login as correct user" do
        get edit_user_path(user)
        follow_redirect!
        expect(request.fullpath).to eq '/login'
        log_in_as(user)
        # expect(request.fullpath).to eq '/users/1' ではなく…
        expect(request.fullpath).to eq '/users/1/edit'
      end
    end
  end
end
