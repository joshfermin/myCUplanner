class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @user = current_user
    @course_ids = @user.courses_taken
    @courses = Course.all
    if @course_ids != nil
      @courses_taken = Course.find(@course_ids)
      @ordered_by = params[:order_by] if params.has_key? 'order_by'

      @course_taken_numbers = Array.new
      for course in @courses_taken
        @course_taken_numbers << course.course_number
      end

      @courses = @courses.where.not(id: @course_ids)
      @to_be_removed = @courses.where(:course_number => @course_taken_numbers)
      @remove_ids = Array.new

      for course in @to_be_removed
         @remove_ids << course.id
      end


      @courses = @courses.where.not(id: [@course_ids, @remove_ids])

      if @ordered_by
        @courses = @courses.all(:order => "#{@ordered_by} asc")
      else
        @courses
      end
    else
      @courses = Course.all
    end

  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # These two actions will behave like the standard edit and update actions 
  # but will handle multiple records. The selected_courses action will need a view.

  # In our application Courses is a RESTful resource so the two new actions won’t 
  # be accessible without making a change to our routes file. As we’re adding methods 
  # that will work on a collection of courses we’ll use the :collection option to 
  # add our two new actions.
  def selected_courses
    @courses = Course.find(params[:course_ids])
  end

  def select_courses_taken
    @hide_ids = Array.new
    @courses = Course.all
    @ordered_by = params[:order_by] if params.has_key? 'order_by'
    @to_be_hidden = @courses.where(:course_title => ["REC","Lab"])

    for course in @to_be_hidden
      @hide_ids << course.id
    end

    if @ordered_by
      @courses = @courses.where.not(id: @hide_ids)
      @courses = Course.all(:order => "#{@ordered_by} asc")
    else
      @courses = @courses.where.not(id: @hide_ids)
    end
  end

  def send_to_index
    if params[:course_taken_ids] != nil
      @courses = Course.find(params[:course_taken_ids])
      @add_to_user = Array.new
      for course in @courses
         @add_to_user << course.id
      end

      @user = current_user
      @user.courses_taken = @add_to_user
      @user.save!(validate:false)

      flash[:success] = "Success! You're ready to choose your classes for next semester"
      redirect_to url_for(:controller => 'users', :action => 'show', id: current_user.id)
    else
      flash[:success] = "Success! You're ready to choose your classes for next semester"
      redirect_to url_for(:controller => 'users', :action => 'show', id: current_user.id)
    end

  end


  def send_to_calendar

    @courses = Course.find(params[:course_ids])
    @start_time = Array.new
    @end_time = Array.new
    @title = Array.new
    @day = Array.new
    @instructor = Array.new
    @building = Array.new
    @room_number = Array.new
    @course_id = Array.new

    for course in @courses do
      @course_id << course.id

      if course.course_title != nil
        @title << course.course_title
      else
        @title << ' '
      end

      if course.start_time != nil
        @start_time << course.start_time
      else
        @start_time << ' '
      end

      if course.end_time != nil
        @end_time << course.end_time
      else
        @end_time << ' '
      end

      if course.day != nil
        @day << course.day
        debugger
      end

      if course.instructor != nil
        @instructor << course.instructor
      else
        @instructor << 'TBA'
      end

      if course.building != nil
        @building << course.building
      else
        @building << 'TBA'
      end

      if course.room != nil
        @room_number << course.room
      else
        @room_number << 'TBA'
      end
    end

    require 'chronic'

    limit = @title.length
    limit.times do |count|
      @start = @start_time[count].strftime('%T')
      @end = @end_time[count].strftime('%T')

      @replace_start_m = Chronic.parse("this week monday at " + @start)
      @replace_end_m =  Chronic.parse("this week monday at " + @end)

      @replace_start_t = Chronic.parse("this week tuesday at " + @start)
      @replace_end_t =  Chronic.parse("this week tuesday at " + @end)

      @replace_start_w = Chronic.parse("this week wednesday at " + @start)
      @replace_end_w =  Chronic.parse("this week wednesday at " + @end)

      @replace_start_th = Chronic.parse("this week thursday at " + @start)
      @replace_end_th =  Chronic.parse("this week thursday at " + @end)

      @replace_start_f = Chronic.parse("this week friday at " + @start)
      @replace_end_f =  Chronic.parse("this week friday at " + @end)



      Time.zone = "UTC"
      Chronic.time_class = Time.zone

      if @day[count] == "M" #or 'T' or 'TH' or 'W' or 'F'
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_m, :ends_at => @replace_end_m, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save

      elsif @day[count] == "T"
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_t, :ends_at => @replace_end_t, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save

      elsif @day[count] == "TH"
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_th, :ends_at => @replace_end_th, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save

      elsif @day[count] == "W"
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_w, :ends_at => @replace_end_w, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save

      elsif @day[count] == "F"
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_f, :ends_at => @replace_end_f, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save

      elsif @day[count] == "M/W/F"
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_m, :ends_at => @replace_end_m, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_w, :ends_at => @replace_end_w, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_f, :ends_at => @replace_end_f, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save

      elsif @day[count] == "M/W"
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_m, :ends_at => @replace_end_m, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_w, :ends_at => @replace_end_w, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save

      elsif @day[count] == "T/TH"
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_t, :ends_at => @replace_end_t, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save
        @event = current_user.events.build(:title => @title[count], :starts_at => @replace_start_th, :ends_at => @replace_end_th, :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save

      else
        @event = current_user.events.build(:title => @title[count], :starts_at => @start_time[count], :ends_at => @end_time[count], :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
        @event.save
      end

      #@event = current_user.events.build(:title => @title[count], :starts_at => @start_time[count], :ends_at => @end_time[count], :all_day => false, :description => "Instructor: " + @instructor[count] + "\n Building: " + @building[count] + "\n Room: " + @room_number[count] + "\n Days: " + @day[count], :course_id => @course_id[count])
      #@event.save
    end


    redirect_to url_for(:controller => 'events', :action => 'create')
    flash[:success] = "Courses successfully added to calendar"
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
      @course = Course.all
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
