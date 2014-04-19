require 'spec_helper'

describe "courses/edit" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :subject_area => "MyString",
      :course_number => 1,
      :ext_number => 1,
      :course_title => "MyString",
      :instructor => "MyString",
      :day => "MyString",
      :start_time => "MyString",
      :end_time => "MyString",
      :building => "MyString",
      :room => "MyString"
    ))
  end

  it "renders the edit course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_path(@course), "post" do
      assert_select "input#course_subject_area[name=?]", "course[subject_area]"
      assert_select "input#course_course_number[name=?]", "course[course_number]"
      assert_select "input#course_ext_number[name=?]", "course[ext_number]"
      assert_select "input#course_course_title[name=?]", "course[course_title]"
      assert_select "input#course_instructor[name=?]", "course[instructor]"
      assert_select "input#course_day[name=?]", "course[day]"
      assert_select "input#course_start_time[name=?]", "course[start_time]"
      assert_select "input#course_end_time[name=?]", "course[end_time]"
      assert_select "input#course_building[name=?]", "course[building]"
      assert_select "input#course_room[name=?]", "course[room]"
    end
  end
end
