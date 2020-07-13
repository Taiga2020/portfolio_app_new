class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #登録(保存)成功
      flash[:success] = "Anime Searcher にようこそ！"
      redirect_to @user #user_url(@user)
    else
      #登録(保存)失敗
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
