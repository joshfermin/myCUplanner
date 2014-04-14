json.array!(@courses) do |course|
  json.extract! course, :course_number, :course_title, :room, :instructor, :time
  json.url course_url(course, format: :json)
end