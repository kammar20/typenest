class Blog < ApplicationRecord

  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: {minimum: 6, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
  validates :image, presence: true

end



