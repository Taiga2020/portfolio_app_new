class GuestSessionsController < ApplicationController
  # skip_before_action :login_required
  # skip_before_action :logged_in_user

  def create
    user = User.find_by(email: 'example-1@railstutorial.org')
    log_in(user)
    flash[:success] = 'ゲストユーザーでログインしました'
    flash[:warning] = 'よろしくお願いします！'
    redirect_to user_path(user)
  end

  # private
    # def login_required
      # redirect_to login_path unless current_user
    # end
end
