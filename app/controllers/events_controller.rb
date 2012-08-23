class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day.  It should be possiblt to change
    # this to be starts_at and ends_at to match rails conventions.
    # I'll eventually do that to make the demo a little cleaner.
    @events = Event.scoped
    @events = @events.after(params['start']) if (params['start'])
    @events = @events.before(params['end']) if (params['end'])

    @users = User.where("last_name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.html # index.html.haml
      format.js  { render :json => @events }
      format.json { render :json => @users.map(&:attributes) }
    end
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js { render :json => @event.to_json }
    end
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.haml
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @all_users = User.all
  end

  # POST /events
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        if params[:send_to_users][:user_tokens] == ""
          @event.event_users.create(:user_id => current_admin.id)
        else
          params[:send_to_users][:user_tokens].split(",").each do |user|
            @event.event_users.create(:user_id => user.to_i)
          end
        end

        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  # PUT /events/1.js
  # when we drag an event on the calendars (from day to day on the month view, or stretching
  # it on the week or day view), this method will be called to update the values.
  # viv la REST!
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.js { head :ok}
      else
        format.html { render :action => "edit" }
        format.js  { render :js => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to params[:owner]? calendar_path : :back}
    end
  end

  def add_user
    render :partial =>'/events/user_list', locals: {:all_users => @users}
  end

end

