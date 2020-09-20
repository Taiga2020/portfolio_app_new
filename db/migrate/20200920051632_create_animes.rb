class CreateAnimes < ActiveRecord::Migration[6.0]
  def change
    create_table :animes do |t|
      t.string :title, null: false
      t.string :image
      t.text :description

      t.timestamps
    end
    add_index :animes, :title, unique: true
  end
end
