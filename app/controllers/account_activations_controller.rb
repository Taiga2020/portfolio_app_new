class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      # user.update_attribute(:activated, true) # >> models/user.rb
      user.activate
      log_in user
      flash[:success] = "Anime Searcherにようこそ！"
      redirect_to user
    else
      flash[:danger] = "アカウントの有効化に失敗しました"
      redirect_to root_url
    end
  end
end
