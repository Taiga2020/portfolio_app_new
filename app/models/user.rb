class User < ApplicationRecord
  #仮想的な属性：「remember_token」属性を作成する（実際にはcookiesに属する）
  attr_accessor :remember_token, :activation_token, :reset_token

  before_save :downcase_email
  before_create :create_activation_digest
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name,
    presence: true,
    length: { maximum: 50 }
  validates :email,
    presence: true,
    length: { maximum: 255 },
    # format: { with: VALID_EMAIL_REGEX },
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password,
      presence: true,
      length: { minimum: 6 }

#「new_token」「digest」「remember」「autheticated?」の役割：
# 永続ログインを実現する為に、ユーザーIDを認証用にアプリ側に保存しておきたい。
#（IDの保存はsessions_helper.rb内のrememberメソッドで実現）
# この際に専用のパスワードを１ペア生成することで、正確にかつ安全に永続化を実現できる。
# ここでは、その１ペアの専用パスワード(トークン)を生成し、比較している。

  class << self
    # User(self).new_token ランダムな文字列を生成する（新しいトークンを生成する）
    def new_token
      SecureRandom.urlsafe_base64
    end

    # User.digest(string) 渡された文字列をハッシュ化する（暗号化したトークン(＝ダイジェスト)を生成する）
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  # rememberメソッドの働き：
  # ①new_tokenで生成したトークン：仮想カラム「remember_token」に代入（DBに保存しない）
  # ②同じトークンをdigestメソッドで暗号化したもの：DBの「remember_digest」カラムに保存
  # 効能：DBに保存する②とは別にDBに保存されない①があり、さらに②は暗号化されているので、
  #      仮にDBの情報を抜き取られても、セキュリティ的に安全である。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # remember_tokenに保存されたトークン①が、
  # DB(remember_digest)に保存された暗号化トークン②と一致しているとtrueを返す
  # def authenticated?(remember_token)
  #   return false if remember_digest.nil?
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end

  # remember_token,activation_tokenの両方でこのメソッドを利用できるように変更
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報(記憶ダイジェスト)を破棄する（nilを代入する）
  def forget
    update_attribute(:remember_digest, nil)
  end

  # アカウントを有効にする
  def activate
    update_attribute(:activated, true)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    # update_attribute(:reset_digest,  User.digest(reset_token))
    # update_attribute(:reset_sent_at, Time.zone.now)
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定URLの有効期限
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
    def downcase_email #このメソッドはuser.rb内でのみ使用するのでprivate下に定義
      # email.downcase!
      self.email = email.downcase
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
