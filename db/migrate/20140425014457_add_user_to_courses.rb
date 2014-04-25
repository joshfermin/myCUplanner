class AddUserToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :user_id, :integer
    add_index :courses, [:user_id, :created_at]
  end
end
