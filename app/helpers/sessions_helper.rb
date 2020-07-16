module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す（いる場合）
  def current_user
    if session[:user_id]
      # @current_userがnilの場合は(@current_userを飛ばして)User.find_by()を代入し、
      # @current_userがnilでない場合は@current_userをそのまま代入する。
      # (例) @current_user = @current_user || User.find_by(session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    end
    # 上の式は下の式と同値（current_userがnilの場合、user_idで検索したユーザー情報を代入する）
    # if @current_user.nil?
    #   @current_user = User.find_by(id: session[:user_id])
    # else
    #   @current_user
    # end
  end

  # ユーザーがログインしているかどうかを判別する（ログインしている場合はtrue,していなければfalse）
  def logged_in?
    !current_user.nil?
  end

  # ログアウト
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
