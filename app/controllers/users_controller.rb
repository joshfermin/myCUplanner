class UsersController < ApplicationController
  
  def new
    @user = User.new # creates a User instance with null attr
  end

  #def add_courses
  #  courses = Array.new
  #  params[:courses_taken].each do |value|
  #    courses << value
  #    User.courses_taken =  courses
  #  end
  #end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to myCUplanner, please select your courses taken" # flash notice that tells the user that the sign up was successful
      #redirect_to @user
      redirect_to url_for(:controller => 'courses', :action => 'select_courses_taken')
    else
      render 'new'
    end
  end

  def show
    if signed_in?
      @user = current_user
      @course_ids = @user.courses_taken

      if @course_ids == nil
        @courses_taken = Course.find([2,3])
        # implement something here for freshman who havent had classes yet
      else
        @courses_taken = Course.find(@course_ids)
      end

      @user_events = Event.where(:user_id => @user.id)
      @course_event_ids = Array.new
      for events in @user_events
         @course_event_ids << events.course_id
      end



      if @course_event_ids.empty?
        @courses_for_next_semester = Course.find([2,3])
        # this is a hack
      else
        @course_event_ids.compact!.uniq!
        @courses_for_next_semester = Course.find(@course_ids)
      end
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :courses_taken)
  end


end
