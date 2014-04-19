require 'spec_helper'

describe "courses/show" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Subject Area/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Course Title/)
    rendered.should match(/Instructor/)
    rendered.should match(/Day/)
    rendered.should match(/Start Time/)
    rendered.should match(/End Time/)
    rendered.should match(/Building/)
    rendered.should match(/Room/)
  end
end
