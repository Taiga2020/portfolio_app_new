# spec/support/shared_examples.rb

  # ユーザの削除（admin権限）
  # users#destroy

  # 成功
  shared_examples_for "success delete user" do
    scenario "user decrememt -1" do
      # visit root_path
      # click_link "ユーザー一覧"
      visit users_path
      expect(page).to have_current_path("/users")
      # expect(page).to have_text "delete"
      # expect(page).to have_link('delete', href: user_path(User.first))
      # expect(page).to have_link('delete', href: user_path(User.second))
      expect(page).to have_link('delete')
      expect(page).not_to have_link('delete', href: user_path(User.first))
      expect {
        click_link('delete', match: :first)
        # 成功メッセージ
        expect(page).to have_css("div.alert.alert-success", text: "ユーザーが削除されました")
      }.to change(User, :count).by(-1)
    end
  end

  # 失敗
  shared_examples_for "fail delete user" do
    scenario "user decrement 0" do
      # click_link "ユーザー一覧"
      visit users_path
      expect(page).to have_current_path("/users")
      expect(page).not_to have_link('delete', href: user_path(User.first))
      expect(page).not_to have_link('delete', href: user_path(User.second))
      expect {
        # リンクが無いので、直接 HTTPリクエストを発行
        delete user_path(User.first)
      }.to change(User, :count).by(0)
    end
  end
