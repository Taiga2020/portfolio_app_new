class AddFuriganaToAnimes < ActiveRecord::Migration[6.0]
  def change
    add_column :animes, :furigana, :string
  end
end
