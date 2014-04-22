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
      flash[:success] = "Welcome to myCUplanner" # flash notice that tells the user that the sign up was successful
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :courses_taken)
  end


end
