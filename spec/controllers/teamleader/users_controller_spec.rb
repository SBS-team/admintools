require "spec_helper"

describe UsersController do

 auth_for :super_admin do

    context "GET #index" do

      it "assigns all users to @users" do
        user = FactoryGirl.create :user
        get :index
        expect(assigns(:users)).to eq([user])
      end

      it "renders the #index view" do
        get :index
        response.should render_template(:index)
      end

    end

    describe "GET #show" do

      it "assigns the requested contact to @contact" do
        user = FactoryGirl.create :user
        get :show, :id => user
        assigns(:user).should eq(user)
      end

      it "renders the #show view" do
        get :show, :id => FactoryGirl.create(:user)
        response.should render_template :show
      end

    end

    describe "GET #new" do

      it "assigns form params[:user] to the new user" do
        user = FactoryGirl.create :user
        get :new
        assigns(:user).should_not be_nil
      end

      it "renders the #new view" do
        get :new, :id => FactoryGirl.create(:user)
        response.should render_template :new
      end

    end

    describe "POST #create" do

      context "with valid attributes" do

        it "creates a new user" do
          expect{
            post :create, :user => FactoryGirl.attributes_for(:user)
          }.to change(User,:count).by(1)
        end

        it "redirects to the new contact" do
          post :create, user: FactoryGirl.attributes_for(:user)
          response.should redirect_to users_path
        end

      end

      context "with invalid attributes" do

        it "does not save the new contact" do
          expect{
            post :create, :user => {}
          }.to_not change(User,:count)
        end

        it "re-renders the new method" do
          post :create, :user => FactoryGirl.attributes_for(:invalid_user)
          response.should render_template :new
        end

      end

    end

    describe "PUT #update" do

      before :each do
        @user = FactoryGirl.create :user
      end

      context "valid attributes" do

        it "located the requested @user" do
          put :update, :id => @user, :user => FactoryGirl.attributes_for(:user)
          assigns(:user).should eq(@user)
        end

        it "changes @user's attributes" do
          put :update, :id => @user, :user => FactoryGirl.attributes_for(:user, :first_name => "Larry", :last_name => "Smith")
          @user.reload
          @user.first_name.should eq("Larry")
          @user.last_name.should eq("Smith")
        end

        it "redirects to the users" do
          put :update, id: @user, contact: FactoryGirl.attributes_for(:user)
          response.should redirect_to users_path
        end

      end

      context "invalid attributes" do
        before :each do
          @first_name = @user.first_name
        end

        it "locates the requested @user" do
          put :update, :id => @user, :user => FactoryGirl.attributes_for(:invalid_user)
          assigns(:user).should eq(@user)
        end

        it "changes @user's attributes" do
          put :update, :id => @user, :user => {:first_name => nil}
          @user.reload.first_name.should == @first_name
        end

        it "re-redirect to edit" do
          put :update, :id => @user, :user => {:first_name => nil, :last_name => nil}
          response.should render_template :edit
        end

      end

    end

    describe "DELETE #destroy" do

      before :each do
        @user = FactoryGirl.create :user
      end

      it "deletes the user" do
        expect{
          delete :destroy, :id => @user
        }.to change(User,:count).by(-1)
      end

      it "redirects to users#index" do
        delete :destroy, :id => @user
        response.should redirect_to users_url
      end

    end
  end

end

#before_filter :init_user, :only => [:index, :show, :update, :destroy]
#before_filter :password_for_user, :only => [:edit_password, :update_password]
#before_filter :select_related_options, :only => [:edit, :update]
#before_filter :show_skills_button, :only => [:index, :show]
#
#
#def index
#  @user_managers = @user.user_managers
#  render 'show'
#end
#
#def show
#  @user_managers = @user.user_managers
#  @skills_button =  (((User.teamleader_users(current_user).include? @user) && (current_user.is_teamleader?)) || current_user.is_manager? || current_user.id == @user.id) && !@user.is_manager?
#  i = 5
#end
#
#def teamleader_users
#  authorize! :look, :teamleader_users
#  @teamlead_bool=true if current_user.is_teamleader?
#  @search = User.where(:department_id=>current_user.department_id).search(params[:search] || {"meta_sort" => "id.asc"})
#  @users=@search.includes(:desktop, :room).paginate(:page => params[:page]).order('created_at').all
#end
#
#def edit
#  @user = User.find(params[:id])
#  authorize! :manage, @user
#  @user_managers = @user.user_manager_ids
#  @managers = User.managers
#end
#
#def update
#  list_managers = params[:ch_managers]||[].map(&:to_i)
#  new_managers = list_managers - @user.user_manager_ids
#  past_managers = @user.user_manager_ids - list_managers
#  past_managers.each {|manager| @user.unmanage! manager }
#  new_managers.each {|manager| @user.manage! manager }
#
#  params[:user].update(:changer => current_user)
#  if @user.update_attributes(params[:user], :as => :user)
#    redirect_to :teamleader_user, :notice => t(:'teamleader.users.update.updated')
#  else
#    render :action => 'edit'
#  end
#end
#
#def birthday
#  @users = {}
#  users = User.where('birthday IS NOT NULL AND birthday!="0000-00-00"').sort_by{ |d| d.birthday.day }
#  Date::MONTHNAMES[1..-1].each do |month|
#    @users[month] = users.select{ |u| u.birthday.strftime("%B") == month }
#  end
#end
#
#def edit_password
#end
#
#def update_password
#  params[:user].select! { |k,v| k.in? %w`current_password password password_confirmation` }
#  if @user.update_with_password(params[:user])
#    sign_in(@user, :bypass => true)
#    redirect_to root_path, notice: t(:'teamleader.users.update_password.updated')
#  else
#    render 'edit_password'
#  end
#end
#
#def manage
#  @user = User.find params[:id]
#  current_user.manage! @user
#end
#
#def unmanage
#  @user = User.find params[:id]
#  current_user.unmanage! @user
#end
#
#private
#def init_user
#  if params[:id]
#    @user = User.find_by_id(params[:id])
#  else
#    @user = current_user
#  end
#end
#
#def password_for_user
#  @user = current_user
#end
#
#def select_related_options
#  @departments = Department.all
#  @managers = User.managers
#end
#
#def show_skills_button
#  @skills_button =  (((User.teamleader_users(current_user).include? @user) && (current_user.is_teamleader?)) ||
#      current_user.is_manager? || current_user.id == @user.id) && !@user.is_manager?
#end