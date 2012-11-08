class Teamleader::RoomsController < ApplicationController

  def index
    @rooms = Room.includes(:workplaces => [ :desktop => [ :user ] ]).all
  end
end