class Anime < ApplicationRecord
  has_many :users, through: :favorites
  has_many :favorites, dependent: :destroy
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
    when '投稿が新しい順'
      return all.order(created_at: :DESC)
    when '投稿が古い順'
      return all.order(created_at: :ASC)
    when '50音順'
      return all.order(furigana: :ASC)
    # when 'likes'
      # return find(Favorite.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    # when 'dislikes'
    #   return find(Favorite.group(:post_id).order(Arel.sql('count(post_id) asc')).pluck(:post_id))
    end
  end

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
