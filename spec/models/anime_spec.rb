require 'rails_helper'

RSpec.describe Anime, type: :model do

  let(:anime) { Anime.new(
    title: "アニメタイトル",
    image: "anime_test.img",
    description: "anime description",
    furigana: "あにめたいとる"
  ) }

  describe "Anime" do
    it "should be valid" do
      expect(anime).to be_valid
    end
  end

  describe "title" do
    it "gives presence" do
      anime.title = "  "
      expect(anime).to be_invalid
    end
  end
end
