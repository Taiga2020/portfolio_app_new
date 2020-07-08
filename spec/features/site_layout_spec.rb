require 'rails_helper'

RSpec.describe "SiteLayouts", type: :feature do
  describe "home layout" do
    before do
      visit root_path
    end
    it "contains root link" do
      expect(page).to have_link nil, href: root_path, count: 2
    end
    it "contains about link" do
      expect(page).to have_link 'About', href: about_path
    end
    it "contains help link" do
      expect(page).to have_link 'Help', href: help_path
    end
    it "contains signup link" do
      expect(page).to have_link 'アカウント登録', href: signup_path
    end
  end

  describe "title layout" do
    it "contains アカウント登録 in signup-page title" do
      # visit signup_path
      pending "不明点：expect(title)??"
    end
  end
end
