class EventsController < ApplicationController
  layout false, :only => [:new, :show, :edit]

  def index
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
  end

  def edit
    @event = Event.find(params[:id])
    @all_admins = Admin.all
  end

  def create
    @event = Event.new(params[:event])
    if params[:send_to_admins][:admin_tokens] == ""
      @event.event_admins.build(:admin_id => current_admin.id)
    else
      params[:send_to_admins][:admin_tokens].split(",").each do |admin|
        @event.event_admins.build(:admin_id => admin.to_i)
      end
    end

    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to events_path }
        format.js { head :ok}
      else
        format.html { render :action => "edit" }
        format.js  { render :js => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to params[:owner]? events_path : :back
  end

end

