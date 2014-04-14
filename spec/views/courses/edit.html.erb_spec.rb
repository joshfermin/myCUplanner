require 'spec_helper'

describe "courses/edit" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :course_number => 1,
      :course_title => "MyString",
      :recitation_number => 1,
      :room => "MyString",
      :instructor => "MyString",
      :time => "MyString"
    ))
  end

  it "renders the edit course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_path(@course), "post" do
      assert_select "input#course_course_number[name=?]", "course[course_number]"
      assert_select "input#course_course_title[name=?]", "course[course_title]"
      assert_select "input#course_recitation_number[name=?]", "course[recitation_number]"
      assert_select "input#course_room[name=?]", "course[room]"
      assert_select "input#course_instructor[name=?]", "course[instructor]"
      assert_select "input#course_time[name=?]", "course[time]"
    end
  end
end
