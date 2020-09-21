class Anime < ApplicationRecord
  has_many :users, through: :favorites
  has_many :favorites, dependent: :destroy
  validates :title, presence: true
  # validate :validate_picture

  def resize_image
    return self.image.variant(resize: '200x200').processed
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
