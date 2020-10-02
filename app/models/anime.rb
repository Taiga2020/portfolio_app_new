class Anime < ApplicationRecord
  #アソシエーション
  has_many :favorites, dependent: :destroy #アニメが削除されると、favoriteも削除される
  has_many :users, through: :favorites #中間テーブルfavoritesを通じてusersに繋がっている

  # validates :title, presence: true, uniqueness: true
  validates :title, presence: true
  validates :furigana, presence: true
  validates :description, presence: true
  validates :image, presence: true
  # validate :validate_picture

  def resize_image
    return self.image.variant(resize: '200x200').processed
  end

  def self.sort(selection)
    case selection
    when '追加が新しい順'
      return all.order(created_at: :DESC)
    when '追加が古い順'
      return all.order(created_at: :ASC)
    when '50音順'
      return all.order(furigana: :ASC)
    when 'お気に入り登録者が多い順'
      return find(Favorite.group(:anime_id).order(Arel.sql('count(user_id) desc')).pluck(:anime_id))
    when 'お気に入り登録者が少ない順'
      return find(Favorite.group(:anime_id).order(Arel.sql('count(user_id) asc')).pluck(:anime_id))
    end
  end

  ## お気に入り(Favorite)

  # #登録メソッド
  #   def addfav(anime)
  #     favorites.find_or_create_by(anime_id: anime.id)
  #   end
  #
  # #登録解除メソッド
  #   def removefav(anime)
  #     favorite = favorites.find_by(anime_id: anime.id)
  #     favorite.destroy if favorite
  #   end
  #
  # #確認メソッド
  #   def checkfav?(anime)
  #     self.users.include?(anime)
  #   end
  #   #self.animesの"animes"はhas_manyで定義したもの(:animes)

  private
    # def validate_picture
    #   if image.attached?
    #     if !image.content_type.in?(%('image/jpeg image/jpg image/png image/gif'))
    #       errors.add(:image, 'はjpeg, jpg, png, gif以外の投稿ができません')
    #     elsif image.blob.byte_size > 5.megabytes
    #       errors.add(:image, "のサイズが5MBを超えています")
    #     end
    #   end
    # end
end
