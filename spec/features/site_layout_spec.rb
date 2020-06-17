require 'rails_helper'

RSpec.describe "SiteLayouts", type: :feature do
  describe "home layout" do
    it "contains root link" do
      visit root_path
      expect(page).to have_link nil, href: root_path, count: 2
    end

    it "contains about link" do
      visit about_path
      expect(page).to have_link 'About', href: about_path
    end

    it "contains help link" do
      visit help_path
      expect(page).to have_link 'Help', href: help_path
    end

    it "displays title with About" do
      visit about_path
      expect(page).to have_title full_title('About') 
    end
  end
end
