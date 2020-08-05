RSpec.feature "UsersIndex", type: :feature do

  # include SupportModule
  include_context "setup"

  subject { page }

  describe "index" do
    # ページネーション
    describe "pagination" do
      # （ファクトリをセット）
      # before { users }  # => shared_context 内で定義 #消去
      before do
        create(:user)
        # create(:admin)
        create_list(:test_user, 10)
      end
      # （セットアップの確認）
      it { expect(User.count).to eq 11 } # => 11 (旧：users.count)
      # ページネーションでユーザが表示されること
      scenario "list each user" do
        visit users_path
        should have_current_path("/users")
        should have_title("ユーザー一覧")
        should have_css("h1", text: "ユーザー一覧")
        User.paginate(page: 1).each do |user|
          # expect(page).to have_css("li", text: user.name)
          expect(page).to have_css("li", text: "Michael Example")
        end
      end
    end
  end
end
