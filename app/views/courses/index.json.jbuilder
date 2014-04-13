json.array!(@courses) do |course|
  json.extract! course, :course_number, :course_title, :recitation_number, :room, :instructor, :time
  json.url course_url(course, format: :json)
end