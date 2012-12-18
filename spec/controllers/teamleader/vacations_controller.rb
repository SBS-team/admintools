require 'spec_helper'

describe Teamleader::VacationsController do

end

#class Teamleader::VacationsController < Teamleader::AppTeamleaderController
#
#  around_filter :preinit, :only => [:edit, :destroy]
#
#  def new
#    @vacation = Vacation.new
#    render :layout => false
#  end
#
#  def show
#    @vacations = User.includes(:vacations).all.map {|v| v.vacation_data(current_user) }
#  end
#
#  def create
#    if (@vacation = current_user.vacations.create(params[:vacation])).persisted?
#      redirect_to teamleader_vacations_path
#    else
#      render :action => :new
#    end
#  end
#
#  def edit
#    render :action => :new, :layout => false
#  end
#
#  def update
#    @vacation = (current_user.is_admin? ? Vacation : current_user.vacations).find_by_id(params[:vacation].delete(:id))
#
#    if @vacation && @vacation.update_attributes(params[:vacation])
#      respond_to do |mime|
#        mime.html {redirect_to teamleader_vacations_path}
#        mime.json {head :no_content}
#      end
#    else
#      respond_to do |mime|
#        mime.html {render :action => :new}
#        mime.json {render :json => {:status => false}}
#      end
#    end
#  end
#
#  def destroy
#    @vacation.destroy
#    respond_to do |mime|
#      mime.html {redirect_to teamleader_vacations_path}
#      mime.json {head :no_content}
#    end
#  end
#
#private
#  def preinit
#    if (@vacation = current_user.vacations.find_by_id(params[:vacation].try(:[], :id) || params[:id]))
#      yield
#    else
#      respond_to do |mime|
#        mime.html { render :text => "You do not have access here" }
#        mime.json { render :json => {:status => false} }
#      end
#    end
#  end
#end