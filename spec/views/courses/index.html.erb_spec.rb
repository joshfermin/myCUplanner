require 'spec_helper'

describe "courses/index" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
        :course_number => 1,
        :course_title => "Course Title",
        :recitation_number => 2,
        :room => "Room",
        :instructor => "Instructor",
        :time => "Time"
      ),
      stub_model(Course,
        :course_number => 1,
        :course_title => "Course Title",
        :recitation_number => 2,
        :room => "Room",
        :instructor => "Instructor",
        :time => "Time"
      )
    ])
  end

  it "renders a list of courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Course Title".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Room".to_s, :count => 2
    assert_select "tr>td", :text => "Instructor".to_s, :count => 2
    assert_select "tr>td", :text => "Time".to_s, :count => 2
  end
end
