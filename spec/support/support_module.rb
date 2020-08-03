module SupportModule
  def login_as(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    find(".form-submit").click
  end
end
