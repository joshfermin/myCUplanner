class AddCoursesTakenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :courses_taken, :string, array: true
  end
end
