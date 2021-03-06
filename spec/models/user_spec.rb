require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User", email: "user@colorado.edu",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user } #makes @user the default subject of test

  it { should respond_to(:name) } # tests if name exists
  it { should respond_to(:email)} # tests if email exists
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@colorado.edu A_US-ER@colorado.edu frst.lst@colorado.edu a+b@colorado.edu]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when name is not present" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid}
  end

  describe "event associations" do

    before { @user.save }
    let!(:older_event) do
      FactoryGirl.create(:event, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_event) do
      FactoryGirl.create(:event, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right events in the right order" do
      expect(@user.events.to_a).to eq [newer_event, older_event]
    end
  end

  it "should destroy associated events" do
    events = @user.events.to_a
    @user.destroy
    expect(events).not_to be_empty
    events.each do |event|
      expect(Event.where(id: event.id)).to be_empty
    end
  end
end
