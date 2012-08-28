class EventsController < ApplicationController
  layout false, :only => [:new, :show]
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

    @admins = Admin.where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.html # index.html.haml
      format.js  { render :json => @events }
      format.json { render :json => @admins.map(&:attributes) }
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
    @event = Event.new(:starts_at => params[:start], :ends_at => params[:end], :send_at => params[:start], :all_day => params[:all_day])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @all_admins = Admin.all
  end

  # POST /events
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        if params[:send_to_admins][:admin_tokens] == ""
          @event.event_admins.create(:admin_id => current_admin.id)
        else
          params[:send_to_admins][:admin_tokens].split(",").each do |admin|
            @event.event_admins.create(:admin_id => admin.to_i)
          end
        end

        format.html { redirect_to calendar_path }
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
        format.html { redirect_to calendar_path }
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

  def add_admin
    render :partial =>'/events/admin_list', locals: {:all_admins => @admins}
  end

end

