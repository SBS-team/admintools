class Admin::EventsController < Admin::AppAdminController
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
    @event = Event.new(params[:event].update(:event_admins_attributes => convert_params(params[:send_to_admins])))
    @event.repeat_events = params[:repeat_events][:select_repeat_events]       # go to model.after_save
    @event.event_days = params[:days] if params[:days]                            # go to model.after_save

    if @event.save
      redirect_to admin_events_path
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if params[:send_to_admins]
      EventAdmin.where(:event_id => @event.id).destroy_all
      params[:event].update(:event_admins_attributes => convert_params(params[:send_to_admins]))
    else
      params[:event].update(:send_at => params[:event][:starts_at], :sended => false)
    end
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to admin_events_path }
        format.js { head :ok}
      else
        format.html { render :action => "edit" }
        format.js  { render :js => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    if params[:delete_group]
      Event.where(:group_id => params[:delete_group]).destroy_all
    else
      Event.find(params[:id]).destroy
    end
    redirect_to admin_events_path
  end

  private

  def convert_params(params)
    params[:admin_tokens]=="" ? [{:admin_id => current_admin.id}] : params[:admin_tokens].split(",").map{|t| {:admin_id => t}}
  end
end

