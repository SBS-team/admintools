class Teamleader::UsersController < Teamleader::AppTeamleaderController
  before_filter :init_user, :only => [:index, :show, :update, :destroy]
  before_filter :password_for_user, :only => [:edit_password, :update_password]
  before_filter :select_related_options, :only => [:edit, :update]
  before_filter :show_skills_button, :only => [:index, :show]


  def index
    @user_managers = @user.user_managers
    render 'show'
  end

  def show
    @user_managers = @user.user_managers
    @skills_button =  (((User.teamleader_users(current_user).include? @user) && (current_user.is_teamleader?)) || current_user.is_manager? || current_user.id == @user.id) && !@user.is_manager?
    i = 5
  end

  def teamleader_users
    authorize! :look, :teamleader_users
    @teamlead_bool=true if current_user.is_teamleader?
    @search = User.where(:department_id=>current_user.department_id).search(params[:search] || {"meta_sort" => "id.asc"})
    @users=@search.includes(:desktop, :room).paginate(:page => params[:page]).order('created_at').all
  end

  def edit
    @user = User.find(params[:id])
    authorize! :manage, @user
    @user_managers = @user.user_manager_ids
    @managers = User.managers
  end

  def update
    list_managers = params[:ch_managers]||[].map(&:to_i)
    new_managers = list_managers - @user.user_manager_ids
    past_managers = @user.user_manager_ids - list_managers
    past_managers.each {|manager| @user.unmanage! manager }
    new_managers.each {|manager| @user.manage! manager }

    params[:user].update(:changer => current_user)
    if @user.update_attributes(params[:user], :as => :user)
      redirect_to :teamleader_user, :notice => t(:'teamleader.users.update.updated')
    else
      render :action => 'edit'
    end
  end

  def birthday
    @users = {}
    users = User.where('birthday IS NOT NULL AND birthday!="0000-00-00"').sort_by{ |d| d.birthday.day }
    Date::MONTHNAMES[1..-1].each do |month|
      @users[month] = users.select{ |u| u.birthday.strftime("%B") == month }
    end
  end

  def edit_password
  end

  def update_password
    params[:user].select! { |k,v| k.in? %w`current_password password password_confirmation` }
    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to root_path, notice: t(:'teamleader.users.update_password.updated')
    else
      render 'edit_password'
    end
  end

  def manage
    @user = User.find params[:id]
    current_user.manage! @user
  end

  def unmanage
    @user = User.find params[:id]
    current_user.unmanage! @user
  end

  private
  def init_user
    if params[:id]
      @user = User.find_by_id(params[:id])
    else
      @user = current_user
    end
  end

  def password_for_user
    @user = current_user
  end

  def select_related_options
    @departments = Department.all
    @managers = User.managers
  end

  def show_skills_button
    @skills_button =  (((User.teamleader_users(current_user).include? @user) && (current_user.is_teamleader?)) ||
                           current_user.is_manager? || current_user.id == @user.id) && !@user.is_manager?
  end

end