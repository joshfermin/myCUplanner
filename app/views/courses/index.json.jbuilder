json.array!(@courses) do |course|
  json.extract! course, :subject_area, :course_number, :ext_number, :course_title, :instructor, :day, :start_time, :end_time, :building, :room
  json.url course_url(course, format: :json)
end