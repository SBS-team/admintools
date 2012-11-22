class VacationsController < ApplicationController
  def show
    @users = User.includes(:vacations).all
  end

  def update

  end
end