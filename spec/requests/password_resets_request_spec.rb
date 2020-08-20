require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do

  let(:user) { create(:user) }

  # createアクション
  describe "POST /password_resets" do
    # 無効なメールアドレス
    it "is invalid email adress" do
      get new_password_reset_path
      expect(request.fullpath).to eq '/password_resets/new'
      post password_resets_path, params: { password_reset: { email: "" } }
      expect(flash[:danger]).to be_truthy
      expect(request.fullpath).to eq '/password_resets'
    end
    # 有効なメールアドレス
    it "is valid email adress" do
      get new_password_reset_path
      expect(request.fullpath).to eq '/password_resets/new'
      post password_resets_path, params: { password_reset: { email: user.email } }
      expect(flash[:info]).to be_truthy
      expect(flash[:danger]).to be_falsey
      follow_redirect!
      expect(request.fullpath).to eq '/'
    end
  end

  # editアクション（メール送信〜URLクリック）
  describe "GET /password_resets/:id/edit" do
    # 無効なメールアドレス
    it "is invalid email adress" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: "")
      expect(flash[:danger]).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/password_resets/new'
    end

    # 無効なユーザー
    it "is invalid user" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      user.toggle!(:activated)
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(flash[:danger]).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/password_resets/new'
      user.toggle!(:activated)
    end

    # 無効なトークン
    it "is invalid reset_token" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path('wrong token', email: user.email)
      expect(flash[:danger]).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/password_resets/new'
    end

    # 有効なメールアドレス・ユーザー・トークン
    it "is valid information" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(flash[:danger]).to be_falsey
      expect(request.fullpath).to eq "/password_resets/#{user.reset_token}/edit?email=#{CGI.escape(user.email)}"
    end
  end

  # updateアクション（新旧パスワード入力画面）
  describe "PATCH /password_resets/:id" do
    # 無効なパスワード
    it "is invalid password" do
      post password_resets_path, params: { password_reset: { email: user.email } } #メール送信
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: user.email) #送られてきたURLをクリック
      #パスワード入力画面
      patch password_reset_path(user.reset_token), params: {
        email: user.email,
        user: {
          password: "foobar",
          password_confirmation: "barbaz"
        }
      }
      expect(request.fullpath).to eq "/password_resets/#{user.reset_token}"
    end

    # 空のパスワード
    it "is empty password" do
      post password_resets_path, params: { password_reset: { email: user.email } } #メール送信
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: user.email) #送られてきたURLをクリック
      #パスワード入力画面
      patch password_reset_path(user.reset_token), params: {
        email: user.email,
        user: {
          password: "",
          password_confirmation: ""
        }
      }
      expect(request.fullpath).to eq "/password_resets/#{user.reset_token}"
    end

    # 期限切れのトークン
    it "has expired token" do
      post password_resets_path, params: { password_reset: { email: user.email } } #メール送信
      user = assigns(:user)
      user.update_attribute(:reset_sent_at, 3.hours.ago) #トークン発行後３時間が経過（＞２時間）
      get edit_password_reset_path(user.reset_token, email: user.email) #送られてきたURLをクリック
      #パスワード入力画面
      patch password_reset_path(user.reset_token), params: {
        email: user.email,
        user: {
          password: "foobaz",
          password_confirmation: "foobaz"
        }
      }
      expect(flash[:danger]).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq "/password_resets/new"
    end

    # 有効なパスワード
    it "is valid information" do
      post password_resets_path, params: { password_reset: { email: user.email } } #メール送信
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: user.email) #送られてきたURLをクリック
      #パスワード入力画面
      patch password_reset_path(user.reset_token), params: {
        email: user.email,
        user: {
          password: "foobaz",
          password_confirmation: "foobaz"
        }
      }
      expect(flash[:success]).to be_truthy
      expect(is_logged_in?).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq "/users/1"
    end
  end

end
