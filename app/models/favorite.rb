class Favorite < ApplicationRecord
  #アソシエーション
  belongs_to :user
  belongs_to :anime

  validates :user_id, presence: true, uniqueness: {scope: :anime_id}
  validates :anime_id, presence: true
end
