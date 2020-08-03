module SessionsHelper

  # 渡されたユーザーでログインする（＝対応するセッションにログインする）
  def log_in(user)
    session[:user_id] = user.id
  end

  # IDとトークンを保存する
  def remember(user)
    # ①new_tokenで生成したトークン：仮想カラム「remember_token」に代入（DBに保存しない）
    # ②同じトークンをdigestメソッドで暗号化したもの：DBの「remember_digest」カラムに保存
    user.remember
    # ユーザーIDを永続cookiesに保存
    cookies.permanent.signed[:user_id] = user.id
    # 仮想カラムremember_tokenに代入された記憶トークンを永続cookiesに保存
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 現在ログイン中のユーザーを返す（いる場合）
  def current_user
    if (user_id = session[:user_id]) #セッションが存在する場合（一時セッション）
      # @current_userがnilの場合は(@current_userを飛ばして)User.find_by()を代入し、
      # @current_userがnilでない場合は@current_userをそのまま代入する。
      # (例) @current_user = @current_user || User.find_by(session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id]) #永続cookiesが存在する場合（永続セッション）
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user #単なる「ログイン」ではなく、"対応するセッションに"ログインする意。
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end

  # def current_user?(user)
  #  user && user == current_user
  # end

  # ユーザーがログインしているかどうかを判別する（ログインしている場合はtrue,していなければfalse）
  def logged_in?
    !current_user.nil?
  end

  # getリクエストをさせる際、その直前に表示されていたページのリンクを記憶する
  # ログイン後、記憶したリンクがあるならそこにリダイレクトさせる
  def store_location
    session[:forwording_url] = request.original_url if request.get?
  end

  # 記憶したリンクまたは任意のリンクにリダイレクトさせる
  def redirect_back_or(default)
    redirect_to(session[:forwording_url] || default)
    session.delete(:forwording_url)
  end

  # 永続セッション（記憶トークン）を破棄し、remember_tokenを空にする
  # 注(比較)：「forgetメソッド(モデルメソッド)」は【記憶ダイジェスト】を破棄し、
  #         remember_digestに【nilを代入】している
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # ログアウト
  def log_out
    forget(current_user) #上のforgetメソッドを利用
    session.delete(:user_id)
    @current_user = nil
  end

end
