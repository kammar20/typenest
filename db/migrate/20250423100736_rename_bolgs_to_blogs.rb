class RenameBolgsToBlogs < ActiveRecord::Migration[5.0]
  def change
    rename_table :bolgs, :blogs
  end
end
