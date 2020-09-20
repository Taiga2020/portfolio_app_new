require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  include SessionsHelper

  let(:user) { create(:user) }
  let(:no_activation_user) { create(:no_activation_user) }

  # テスト専用のログインメソッド
  def post_valid_information(login_user, remember_me = 0)
    post login_path, params: {
      session: {
        email: login_user.email,
        password: login_user.password,
        remember_me: remember_me
      }
    }
  end

  describe "GET /login" do
    context "invaild information" do
      it "fails login with flash danger message" do
        get login_path
        post login_path, params: {
          session: {
            email: "",
            password: ""
          }
        }
        expect(flash[:danger]).to be_truthy
        expect(is_logged_in?).to be_falsey
        expect(request.fullpath).to eq '/login' #アカウント有効化
      end
    end

    context "vaild information" do
      it "fails because they have not activated account" do #アカウント有効化
        get login_path
        post_valid_information(no_activation_user)
        expect(flash[:danger]).to be_truthy
        expect(is_logged_in?).to be_falsey
        follow_redirect!
        expect(request.fullpath).to eq '/' #アカウント有効化 >>「メールを送信しました」
      end

      it "succeeds login with no flash danger message" do
        get login_path
        post_valid_information(user)
        expect(flash[:danger]).to be_falsey
        expect(is_logged_in?).to be_truthy
        follow_redirect!
        expect(response.body).to include 'Michael Example'
      end

      it "succeeds login and logout" do
        get login_path
        post login_path, params: {
          session: {
            email: user.email,
            password: user.password
          }
        }
        expect(is_logged_in?).to be_truthy
        delete logout_path
        expect(is_logged_in?).to be_falsey
      end
    end
  end

  it "does not logout twice" do
    get login_path #通常のログイン
    post_valid_information(user, 0)
    expect(is_logged_in?).to be_truthy
    follow_redirect!
    expect(response.body).to include 'Michael Example'

    delete logout_path #通常のログアウト(1回目)
    expect(is_logged_in?).to be_falsey
    follow_redirect!
    expect(request.fullpath).to eq '/'

    delete logout_path #ログアウト(2回目)
    follow_redirect!
    expect(request.fullpath).to eq '/'
  end

  context "check remember_me" do
    it "has remember_token after login" do
      get login_path
      post_valid_information(user, 1)
      expect(is_logged_in?).to be_truthy
      expect(cookies[:remember_token]).not_to be_nil
    end

    it "has no remember_token after login and logout" do
      get login_path
      post_valid_information(user, 1)
      expect(is_logged_in?).to be_truthy
      expect(cookies[:remember_token]).not_to be_empty #remember_tokenに値を入れる
      delete logout_path
      expect(is_logged_in?).to be_falsey
      expect(cookies[:remember_token]).to be_empty #値が入ったremember_tokenをdeleteメソッドで空にする
    end
  end

  context "uncheck remember_me" do
    it "has no remember_token after login" do
      get login_path
      post_valid_information(user, 0)
      expect(is_logged_in?).to be_truthy
      expect(cookies[:remember_token]).to be_nil
      # ↑remember_tokenの初期値はnil。そもそもdeleteできないのでnilのまま(?)
    end
  end

end
