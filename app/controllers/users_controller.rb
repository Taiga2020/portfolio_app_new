class UsersController < ApplicationController
  # 「before_action :(〜ではない場合), only[閲覧制限ページ]」
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    # @users = User.paginate(page: params[:page], per_page: 10)
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # #登録(保存)成功
      # log_in @user
      # flash[:success] = "アカウントの作成に成功しました"
      # redirect_to @user #user_url(@user)

      # UserMailer.account_activation(@user).deliver_now # >> models/user.rb
      @user.send_activation_email
      flash[:info] = "認証用メールを送信しました。登録時のメールアドレスから認証を済ませてください"
      redirect_to root_url
    else
      #登録(保存)失敗
      render 'new'
    end
  end

  def edit
    if guest_user
      flash[:danger] = "ゲストユーザーは編集できません"
      flash[:warning] = "ログインしてください"
      redirect_to root_url
    else
      @user = User.find(params[:id])
    end
  end

  def update
    if guest_user
      flash[:danger] = "ゲストユーザーは更新できません"
      flash[:warning] = "ログインしてください"
      redirect_to root_url
    else
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        #編集(更新)成功
        flash[:success] = "アカウントの編集に成功しました"
        redirect_to @user #user_url(@user)
      else
        #編集(更新)失敗
        flash[:danger] = "アカウントの編集に失敗しました"
        # redirect_to edit_user_path(@user) #(旧)render 'edit'
        render 'edit'
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーが削除されました"
    redirect_to users_url
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:warning] = 'ログインしてください'
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
