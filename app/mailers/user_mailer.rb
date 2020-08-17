class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "【重要】Anime Searcherよりアカウント有効化メールをお届けしました"
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
