class AddUserIdToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :user_id, :int
  end
end
