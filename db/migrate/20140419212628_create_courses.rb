class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :subject_area
      t.integer :course_number
      t.integer :ext_number
      t.string :course_title
      t.string :instructor
      t.string :day
      t.datetime :start_time
      t.datetime :end_time
      t.string :building
      t.string :room

      t.timestamps
    end
  end
end
