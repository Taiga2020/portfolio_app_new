require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do

  let(:user) { create(:user) }

  # current_userメソッドの永続セッションの場合の条件分岐部分がテストできていない為、テストする。
  describe "#current_user" do
    # sessionがnilのときも、cookiesの永続セッションを通してログインができているかどうか
    it "returns right user when session is nil" do
      remember(user)
      expect(current_user).to eq user
      expect(is_logged_in?).to be_truthy
    end

    # 不適な(remember_tokenと一致しない)トークンがremember_digestに代入されている場合、
    # current_userは初期値のnilを返すかどうか
    it "returns nil when remember_digest is wrong" do
      remember(user)
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      # ↑適切なのは「user.update_attribute(:remember_digest, User.digest(remember_token))」
      expect(current_user).to be_nil
    end
  end

end
