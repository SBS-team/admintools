require 'spec_helper'

describe Teamleader::DepartmentsController do
  before(:each) do
    sign_in (@user = FactoryGirl.create(:admin))
    CanCan.expects(:load_and_authorize_resource).once.returns(true)
    #@ability = Object.new
    #@ability.extend(CanCan::Ability)
    #@ability.can :manage, Department
    #controller.stub(:load_and_authorize_resource).and_return(@ability)

    #controller.stub(:load_and_authorize_resource).and_return(true)
    #CanCan::ControllerResource.stub(:load_and_authorize_resource).and_return(true)
    #CanCan.expects(:load_and_authorize_resource).once.returns(true)
  end

  describe 'index' do
    before(:each) do
      5.times {FactoryGirl.create(:department)}
      Department.find_by_id(Department.all.select {|v| v.id % 2 == 0}.map(&:id))
    end

    xit 'deleted' do
      get :index, :deleted => '1'
      assigns(:departments).all.select {|v| v.id % 2 != 0}.should be_empty
    end

    xit 'non deleted' do
      get :index
      assigns(:departments).all.select {|v| v.id % 2 == 0}.should be_empty
    end
  end

  xit 'show' do
    @department = FactoryGirl.create(:department)
    get :show, :id => @department.id
    assigns(:department).should eq @department
  end

  xit 'new' do
    get :new
    assigns(:department).should be_new_record
  end

  describe 'create' do
    xit 'valid' do
      post :create, :department => FactoryGirl.build(:department).slice('id', 'created_at', 'updated_at')
      response.should redirect_to :teamleader_departments and should set_the_flash[:notice].to(t(:'teamleader.departments.create.created', name: @department.name))
      assigns(@department).should be_persisted
    end

    xit 'invalid' do
      post :create, :department => {}
      response.should render_template :new
    end
  end

  xit 'edit' do
    @department = FactoryGirl.create(:department)
    get :edit, :id => @department.id
    assigns(:department).should eq @department
  end

  describe 'update' do
    xit 'valid' do
      @department = FactoryGirl.create(:department)
      @department.name.should_not eq "trololo"
      put :update, :department => {:name => "trololo"}, :id => @department.id
      response.should redirect_to :teamleader_departments and should set_the_flash[:notice].to(t(:'teamleader.departments.update.updated'))
      @department.name.should eq "trololo"
    end

    xit 'invalid' do
      @department = FactoryGirl.create(:department)
      put :update, :department => {:name => nil}, :id => @department.id
      response.should render_template :new
    end
  end

  xit 'destroy' do
    @department = FactoryGirl.create(:department)
    delete :destroy, :id => @department.id
    #assigns(:department).deleted?
    response.should redirect_to :teamleader_departments and should set_the_flash[:notice].to(t(:'teamleader.departments.destroy.destroyed', name: @department.name))
  end

  xit 'restore' do
    @department = FactoryGirl.create(:department)
    get :restore, :id => @department.id
    response.should redirect_to teamleader_departments_path(:deleted => 1) and should set_the_flash[:notice].to(t('teamleader.departments.restore.restored', :name => department.name))
  end
end