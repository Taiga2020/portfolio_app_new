class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "【Anime Searcher】アカウント有効化メール"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "【Anime Searcher】パスワード再設定メール"
  end
end
