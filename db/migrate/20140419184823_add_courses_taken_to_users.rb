class AddCoursesTakenToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :courses_taken
    add_column :users, :courses_taken, :string
  end
end
