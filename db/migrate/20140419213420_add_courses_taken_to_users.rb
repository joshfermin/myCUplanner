class AddCoursesTakenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :courses_taken, :text, Array: true
  end
end
