require 'spec_helper'

describe Event do

  let(:user) { FactoryGirl.create(:user) }
  before { @event = user.events.build(description: "Lorem ipsum") }

  subject { @event }

  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @event.user_id = nil }
    it { should_not be_valid }
  end
end