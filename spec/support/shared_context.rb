RSpec.shared_context "setup" do

  # 遅延評価、呼ばれた時にDB保存される
  # let(:user) { User.new(
  #   name: "Example User",
  #   email: "user@example.com",
  #   password: "foobar",
  #   password_confirmation: "foobar"
  # ) }
  let(:users) { create_list(:test_user, 10) }

end
