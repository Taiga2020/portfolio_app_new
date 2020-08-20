require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user) }

  describe "account_activation" do
    it "renders mails" do
      user.activation_token = User.new_token
      mail = UserMailer.account_activation(user)
      expect(mail.subject).to eq("【Anime Searcher】アカウント有効化メール")
      expect(mail.to).to eq(["michael@example.com"])
      expect(mail.from).to eq(["noreply@example.com"])
      # expect(mail.body.encoded).to include("Michael Example")
      # ...はエンコードの関係で通らない。
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include("Michael Example")
    end
  end

  describe "password_reset" do
    it "renders mails" do
      user.reset_token = User.new_token
      mail = UserMailer.password_reset(user)
      expect(mail.subject).to eq("【Anime Searcher】パスワード再設定メール")
      expect(mail.to).to eq(["michael@example.com"])
      expect(mail.from).to eq(["noreply@example.com"])
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include "Michael Example"
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include user.reset_token
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include CGI.escape(user.email)
    end
  end
end
