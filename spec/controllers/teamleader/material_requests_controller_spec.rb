require 'spec_helper'

describe Teamleader::MaterialRequestsController do
  before(:each) do
    @user, @teamleader = user_with_teamleader
    @admin = FactoryGirl.create(:admin)
    2.times {FactoryGirl.create(:material_request, :user => @user)}
    2.times {FactoryGirl.create(:material_request, :user => @user, :status => false)}
    2.times {FactoryGirl.create(:material_request, :user => @teamleader)}
    2.times {FactoryGirl.create(:material_request, :user => @teamleader, :status => true)}
  end

  describe 'index' do
    it 'user' do
      sign_in (@user = FactoryGirl.create(:user))
      get :index
      assigns(:material_requests).should eq @user.material_requests.unconfirmed.order("priority DESC")
    end

    it 'admin' do
     sign_in (@user = FactoryGirl.create(:admin))
     get :index
     assigns(:material_requests).should eq MaterialRequest.unprocessed.unconfirmed.order("priority DESC")
    end

    it 'teamlead' do
     sign_in (@user = FactoryGirl.create(:teamleader))
     get :index
     assigns(:material_requests).should eq MaterialRequest.by_department(@user.department).unconfirmed.order("priority DESC")
    end
  end

  it 'new' do
    sign_in @user
    get :new
    assigns(:material_request).should be_new_request
  end

  describe 'create' do
    before(:each) { sign_in @user }

    it 'valid' do
      post :create, :material_request => FactoryGirl.build(:material_request).slice('id', 'created_at', 'updated_at')
      assigns(:material_request).should_not be_new_record?
      response.should redirect_to teamleader_material_requests_path
    end

    it 'invalid' do
      post :create, :material_request => {}
      response.should render_template :new
    end
  end

  it 'edit' do
    sign_in @user
    @req = FactoryGirl.create(:material_request, :user => @user)
    get :edit, :id => @req.id

    response.should render_template :new
  end

  describe 'update' do
    @req = FactoryGirl.create(:material_request, :user => @user)
    before(:each) { sign_in @user }

    it 'valid' do
      post :create, :material_request => {:name => "qwdaszadasdasdada sdasd"}, :id => @req.id
      assigns(:material_request).name.should eq "qwdaszadasdasdada sdasd"
      response.should redirect_to teamleader_material_requests_path
    end

    it 'invalid' do
      post :create, :material_request => {:name => nil}, :id => @req.id
      response.should render_template :new
    end
  end

  it 'destroy' do
    @req = FactoryGirl.create(:material_request, :user => @user)
    delete :destroy, :id => @req.id
    response.should redirect_to teamleader_material_requests_path
  end
end


#class Teamleader::MaterialRequestsController < Teamleader::AppTeamleaderController
#  before_filter :preinit, :only => [:edit, :update, :destroy, :approve]
#  def send_requests
#    @material_requests = MaterialRequest.by_department(current_user.department).unconfirmed
#    MaterialRequestMailer.send_material_request(@material_requests).deliver
#    @material_requests.update_all(:status => false)
#    redirect_to teamleader_material_requests_path
#  end
#
#  def approve
#    MaterialRequestMailer.material_request_response(@material_request).deliver
#    @material_request.destroy
#    redirect_to teamleader_material_requests_path
#  end
#end