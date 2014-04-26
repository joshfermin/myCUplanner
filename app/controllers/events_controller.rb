class EventsController < ApplicationController
  before_action :signed_in_user


  # GET /events
  # GET /events.json
  def index
    @ordered_by = params[:order_by] if params.has_key? 'order_by'
    @user = current_user.id
    if @ordered_by
      @events = Event.where(['user_id =  ?', @user]).("#{@ordered_by} asc")
    else
      @events = Event.where(['user_id =  ?', @user])
    end

    #@events = Event.between(params['start'], params['end']) if (params['start'] && params['end'])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  # def new
  #   @event = Event.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render :json => @event }
  #   end
  # end

  def new
    @event = Course.find(params[:course_ids])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    #if select_multiple_course_path
    #  @event = current_user.events.build(params.require(:event).permit(:title, :starts_at, :ends_at,
    #                                                                   :all_day, :description))
    #end

    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, :notice => 'Event was successfully created.' }
        format.json { render :json => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, :notice => 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :starts_at, :ends_at,
                                 :all_day, :description)
  end
end