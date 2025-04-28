class User < ApplicationRecord

  def avatar_letter
    email[0].upcase if email.present?
  end

  before_save {self.email = email.downcase}


  has_many :blogs, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy



  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 } 

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  validates :usertitle, presence: true, length: { minimum: 3, maximum: 25 }

  has_secure_password



end
