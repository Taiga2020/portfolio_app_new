require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe "#full_title" do
    context "page_title is empty" do
      it "returns only base_title" do
        expect(helper.full_title).to eq('Anime Searcher')
      end
    end

    context "page_title is not empty" do
      it "returns full_title" do
        expect(helper.full_title('symbol')).to eq('symbol | Anime Searcher')
      end
    end
  end

end
