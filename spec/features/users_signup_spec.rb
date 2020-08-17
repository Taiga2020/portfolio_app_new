require 'rails_helper'

RSpec.describe "UsersSignups", type: :feature do
# 正しく画面遷移されるか
  it "is invalid because it has no name" do
    visit signup_path
    fill_in 'ユーザー名', with: ''
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in 'パスワード', with: 'foo'
    fill_in 'パスワード（再入力）', with: 'bar'
    click_on '登録する'
    # expect(current_path).to eq users_path #本来はsignup_pathであるべき?
    expect(current_path).to eq signup_path
    expect(page).to have_selector '#error_explanation'
    # expect(page).to have_selector 'li', text: '名前を入力してください'
  end

  it "is valid because it fulfils condition of input" do
    visit signup_path
    fill_in 'ユーザー名', with: 'Michael Hartl'
    fill_in 'メールアドレス', with: 'michael@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（再入力）', with: 'password'
    click_on '登録する'
    expect(current_path).to eq root_path
    expect(page).to have_selector '.alert-info'
  end
end
