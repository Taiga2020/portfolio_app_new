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
    it "displays title with アカウント登録 in signup-page" do
      visit signup_path
      expect(page).to have_title full_title('アカウント登録')
    end
  end
end
