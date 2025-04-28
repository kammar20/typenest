class Like < ApplicationRecord
  class Like < ApplicationRecord
    belongs_to :user
    belongs_to :blog
  
    validates :user_id, uniqueness: { scope: :blog_id } # prevents duplicate likes
  end
  
end
