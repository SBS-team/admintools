class CalendarController < ApplicationController
  layout false, :only => :popup

  def index

  end

  def show

  end

  def popup
    @event = Event.new(:starts_at => params[:start], :ends_at => params[:end], :send_at => params[:start])
  end

end
