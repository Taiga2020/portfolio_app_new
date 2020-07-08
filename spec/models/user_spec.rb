require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Userオブジェクトのバリデーションテスト" do
    # before do
    #   @user = User.new(name:"Example User", email:"user@example.com")
    # end
    it "nameとemailを共に持つ場合は valid" do
      user = User.new(name:"Example User", email:"user@example.com")
      expect(user).to be_valid
    end
    it "nameを持たない場合は invalid" do
      user = User.new(name:"  ", email:"user@example.com")
      expect(user).not_to be_valid
    end
    it "emailを持たない場合は invalid" do
      user = User.new(name:"Example User", email:"  ")
      expect(user).not_to be_valid
    end
  end

end
