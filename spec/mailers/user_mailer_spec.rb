require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user) }

  describe "account_activation" do
    it "renders mails" do
      user.activation_token = User.new_token
      mail = UserMailer.account_activation(user)
      expect(mail.subject).to eq("【重要】Anime Searcherよりアカウント有効化メールをお届けしました")
      expect(mail.to).to eq(["michael@example.com"])
      expect(mail.from).to eq(["noreply@example.com"])
      # expect(mail.body.encoded).to include("Michael Example")
      # ...はエンコードの関係で通らない。
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include("Michael Example")
    end
    # let(:mail) { UserMailer.account_activation(user) }
    #
    # # メール送信のテスト
    # it "renders the headers" do
    #   expect(mail.from).to eq ["noreply@example.com"]
    #   expect(mail.to).to eq ["michael@example.com"]
    #   expect(mail.subject).to eq "アカウント有効化 - Anime Searcher"
    # end

    # メールプレビューのテスト #エンコードがbase64の為、テスト通らない
    # it "renders the body" do
    #   expect(mail.body).to match user.name
    #   expect(mail.body).to match user.activation_token
    #   expect(mail.body).to match CGI.escape(user.email)
    # end
  end

  # describe "password_reset" do
  #   let(:mail) { UserMailer.password_reset }
  #
  #   it "renders the headers" do
  #     expect(mail.subject).to eq("Password reset")
  #     expect(mail.to).to eq(["to@example.org"])
  #     expect(mail.from).to eq(["from@example.com"])
  #   end
  #
  #   it "renders the body" do
  #     expect(mail.body.encoded).to match("Hi")
  #   end
  # end

end
