require 'spec_helper'

describe "courses/index" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
        :subject_area => "Subject Area",
        :course_number => 1,
        :ext_number => 2,
        :course_title => "Course Title",
        :instructor => "Instructor",
        :day => "Day",
        :start_time => "Start Time",
        :end_time => "End Time",
        :building => "Building",
        :room => "Room"
      ),
      stub_model(Course,
        :subject_area => "Subject Area",
        :course_number => 1,
        :ext_number => 2,
        :course_title => "Course Title",
        :instructor => "Instructor",
        :day => "Day",
        :start_time => "Start Time",
        :end_time => "End Time",
        :building => "Building",
        :room => "Room"
      )
    ])
  end

  it "renders a list of courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject Area".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Course Title".to_s, :count => 2
    assert_select "tr>td", :text => "Instructor".to_s, :count => 2
    assert_select "tr>td", :text => "Day".to_s, :count => 2
    assert_select "tr>td", :text => "Start Time".to_s, :count => 2
    assert_select "tr>td", :text => "End Time".to_s, :count => 2
    assert_select "tr>td", :text => "Building".to_s, :count => 2
  end
end
