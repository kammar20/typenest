class Blog < ApplicationRecord

  belongs_to :user

  mount_uploader :image, ImageUploader

  has_many :likes, dependent: :destroy


def liked_by?(user)
  likes.exists?(user_id: user.id)
end


  validates :title, presence: true, length: {minimum: 6, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
  validates :image, presence: true

end



