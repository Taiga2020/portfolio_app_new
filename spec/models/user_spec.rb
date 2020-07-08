require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Userオブジェクトのバリデーションテスト" do
    before do
      @user = User.new(name:"Example User", email:"user@example.com")
    end

    it "nameとemailを共に持つ場合はvalid" do
      expect(@user).to be_valid
    end
    it "nameを持たない場合はinvalid" do
      @user.name = "  "
      expect(@user).not_to be_valid
    end
    it "emailを持たない場合はinvalid" do
      @user.email = "  "
      expect(@user).not_to be_valid
    end

    it "name should not be too long" do
      @user.name = "a"*51
      expect(@user).not_to be_valid
    end
    it "email should not be too long" do
      @user.email = "a"*244 + "@example.com"
      expect(@user).not_to be_valid
    end

    it "email validation should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                     first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
      end
    end
    it "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid, "#{invalid_address.inspect} should be invalid"
      end
    end
  end

end
