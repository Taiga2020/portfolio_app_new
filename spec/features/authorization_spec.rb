require 'rails_helper'

RSpec.feature "Authorization", type: :feature do

  # include SupportModule     # => login_as(admin) を使う
  include_context "setup"

  describe "in UsersController", type: :request do

    # （省略）

    # ユーザ削除権限
    describe "authorization of delete user" do
      # before { users } #削除
      before do
        create(:user)
        create_list(:test_user, 10)
        create(:other_user)
      end
      # let(:admin) { create(:admin) }

      it { expect(User.count).to eq 12 } # （セットアップ確認）
      # adminユーザの場合
      context "admin" do
        before do
          visit login_path
          fill_in 'メールアドレス', with: "michael@example.com"
          fill_in 'パスワード', with: "password"
          find(".form-submit").click
          visit root_path
        end
        it_behaves_like "success delete user"
      end
      # 一般ユーザの場合
      context "non-admin" do
        before do
          visit login_path
          fill_in 'メールアドレス', with: "duchess@example.gov"
          fill_in 'パスワード', with: "foobar"
          find(".form-submit").click
          visit root_path
        end
        # ユーザの削除ができないこと
        it_behaves_like "fail delete user"
        # ルートにリダイレクトしていること
        scenario "should redirect to root path" do
          expect(page).to have_current_path("/")
        end
      end
    end
  end
end
