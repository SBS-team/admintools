require 'spec_helper'

describe Teamleader::RoomsController do
  it do
    get :index
    assigns(:rooms).should eq Room.includes(:workplaces => [ :desktop => [ :user ] ]).all
  end
end
