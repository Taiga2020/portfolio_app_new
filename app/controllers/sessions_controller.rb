class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user #user_url(user)と同値。（/users/1, /users/2...）
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
