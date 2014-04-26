class Course < ActiveRecord::Base
	belongs_to :user
	has_many :events
	# default_scope -> { order('course_title DESC') }
end
