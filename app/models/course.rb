class Course < ActiveRecord::Base
	belongs_to :user
	# default_scope -> { order('course_title DESC') }
end
