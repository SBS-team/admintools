require 'spec_helper'

describe Teamleader::AbsentsController do
  before(:each) do
    @user, @admin = user_with_teamleader
    sign_in @user
  end

  it 'index' do
    get :index
    assigns(:absents) == @user.absents
  end

  it 'new' do
    get :new
    assigns(:absent).new_record?
  end

  describe 'create' do
    it 'valid' do
      post :create, :absent => FactoryGirl.build(:absent).attributes.except('id', 'created_at', 'updated_at')
      response.should redirect_to teamleader_absents_path
      last_email.to.should include(@admin.email)
      #last_email.body.should have_content("Change my password")
    end

    it 'invalid' do
      post :create, :absent => {}
      response.should render_template :new
    end
  end

  it 'destroy' do
    @user.absents << FactoryGirl.create(:absent, :user => @user)
    delete :destroy, :id => @user.absents.first.id
    response.should redirect_to teamleader_absents_path
    @user.absents.should be_empty
  end
end
