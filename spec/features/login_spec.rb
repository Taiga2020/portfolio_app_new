require 'rails_helper'

RSpec.describe "Logins", type: :feature do

  let(:user) { create(:user) }

  describe "Login" do
    context "invalid login" do
      it "is invalid because it has no information" do
        visit login_path
        expect(page).to have_selector '.form-container'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        find(".form-submit").click
        expect(current_path).to eq login_path
        expect(page).to have_selector '.form-container'
        expect(page).to have_selector '.alert-danger'
      end

      it "delete flash messages when visit other pages" do
        visit login_path
        expect(page).to have_selector '.form-container'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        find(".form-submit").click
        expect(current_path).to eq login_path
        expect(page).to have_selector '.form-container'
        expect(page).to have_selector '.alert-danger'
        visit root_path
        expect(page).not_to have_selector '.alert-danger'
      end
    end

    context "valid login" do
      it "is valid because it has valid information" do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find(".form-submit").click
        expect(current_path).to eq user_path(1)
        expect(page).to have_selector '.show-container'
      end

      it "replaces login button with logout button" do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find(".form-submit").click
        expect(current_path).to eq user_path(1)
        expect(page).to have_selector '.show-container'
        expect(page).not_to have_link 'ログイン', href: login_path
        expect(page).to have_link 'ログアウト', href: logout_path
      end
    end
  end

  describe "Logout" do
    it "succeeds login and logout" do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      find(".form-submit").click # click_on 'ログイン'
      expect(current_path).to eq user_path(1)
      expect(page).to have_selector '.show-container'
      expect(page).not_to have_link 'ログイン', href: login_path
      expect(page).to have_link 'ログアウト', href: logout_path
      click_on 'ログアウト'
      expect(current_path).to eq root_path
      expect(current_path).not_to eq user_path(1)
      expect(page).to have_selector '.home-container'
      expect(page).to have_link 'ログイン', href: login_path
      expect(page).not_to have_link 'ログアウト', href: logout_path
    end
  end
end
