class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_number
      t.string :course_title
      #t.integer :recitation_number
      t.string :room
      t.string :instructor
      t.string :time

      t.timestamps
    end
  end
end
