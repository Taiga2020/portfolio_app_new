class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # メモ：ログイン後に「マイページ」にリダイレクトさせる
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render 'new'
    end
  end

  def destroy
    # メモ：ログアウトさせる
  end
end
