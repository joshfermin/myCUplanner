class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # These two actions will behave like the standard edit and update actions 
  # but will handle multiple records. The edit_multiple action will need a view.

  # In our application Courses is a RESTful resource so the two new actions won’t 
  # be accessible without making a change to our routes file. As we’re adding methods 
  # that will work on a collection of courses we’ll use the :collection option to 
  # add our two new actions.
  def edit_multiple
    @courses = Course.find(params[:course_ids])
  end
  
  # The update_multiple action starts by getting the array of course ids that we passed 
  # through from the other form as a list of hidden fields. We then loop through each 
  # course and update its attributes. As we only want to update the attributes that aren’t 
  # empty we use reject to loop through each parameter and remove the ones that have a blank 
  # value from the parameter array. Note that we’re using update_attributes! with a bang (!) 
  # as we don’t have any validations on our model. If this was a production application we’d 
  # have validations but that’s beyond the scope of this episode. Using update_attributes! 
  # this way will mean that an exception is thrown if something is invalid. Once all of the 
  # courses have been updated we set a flash message and return back to the courses listing page.  
  # def update_multiple
  #   @courses = Course.find(params[:course_ids])
  #   @courses.each do |course|
  #     course.update_attributes!(params[:course].reject { |k,v| v.blank? })
  #   end
  #   flash[:notice] = "Updated selected courses!"
  #   redirect_to courses_path
  # end
  def update_multiple
    @courses = Course.find(params[:course_ids])
    # @courses.each do |course|
    #   course.update_attributes!(params[:course].reject {|k,v| v.blank?} )
    # end
    flash[:notice] = "Updated Selected Courses"
    redirect_to courses_path
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  require 'csv'

  def csv_import
    @parsed_file=CSV::Reader.parse(params[:dump][:file])
    n=0
    @parsed_file.each  do |row|
      c=Course.new
      c.job_title=row[1]
      c.first_name=row[2]
      c.last_name=row[3]
      if c.save
        n=n+1
        GC.start if n%50==0
      end
      flash.now[:message]="CSV Import Successful,  #{n} new records added to data base"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:subject_area, :course_number, :ext_number, :course_title, :instructor, :day, :start_time, :end_time, :building, :room)
    end

    # def sort_column
    #   Course.column_names.include?(params[:sort]) ? params[:sort] : "name"
    # end

    # def sort_direction
    #   %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    # end
end
