require 'spec_helper'

describe "courses/show" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :course_number => 1,
      :course_title => "Course Title",
      :recitation_number => 2,
      :room => "Room",
      :instructor => "Instructor",
      :time => "Time"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Course Title/)
    rendered.should match(/2/)
    rendered.should match(/Room/)
    rendered.should match(/Instructor/)
    rendered.should match(/Time/)
  end
end
