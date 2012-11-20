class Teamleader::SkillsController < Teamleader::AppTeamleaderController
  before_filter :init_user, :except => [:destroy]
  before_filter -> {@skills = @user.skill_user_relations.includes(:skill)}, :except => [:destroy]
  before_filter -> {@skill_list = Skill.all}
  before_filter :init_skill, :only => [:destroy]
  before_filter :show_skills, :only => [:index, :show]

  def index
    if @show_skills
     render 'show'
    else
      redirect_to :back
    end
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(params[:skill])
    if @skill.save
      redirect_to :show_list_teamleader_skills, notice: t(:'teamleader.skills.create.created', name: @skill.name)
    else
      render :action => 'new'
    end
  end

  def show
    redirect_to :back if !@show_skills
  end

  def edit

  end

  def update
    if (@user==current_user)
      (params[:skill][:score] || []).each { |skill| current_user.skill_user_relations.where(:skill_id => skill.first).first_or_initialize.update_attributes(:score => skill.last) }
      (params[:skill][:delete] || []).each { |skill| current_user.skill_user_relations.where(:skill_id => skill.first).destroy_all }
      redirect_to teamleader_skills_path
    end
  end

  def show_list
    @deleted = params[:deleted]
    if @deleted=="1"
      @skills = Skill.only_deleted
    else
      @skills = Skill.all
    end
  end

  def destroy
    @skill.destroy and redirect_to :show_list_teamleader_skills, notice: t(:'teamleader.skills.destroy.destroyed', name: @skill.name)
  end

  def restore
    authorize! :restore, :skills
    skill = Skill.only_deleted.find_by_id(params[:id])
    skill.recover
    skill.skill_user_relations.with_deleted.each {|skill_user| skill_user.recover}
    redirect_to show_list_teamleader_skills_path(:deleted => 1), :notice => t('teamleader.skills.restore.restored', :name => skill.name)
  end

  private

  def init_skill
    @skill = Skill.find(params[:id])
  end

  def init_user
    if params[:id]||params[:user_id]
      @user = User.find_by_id((params[:id]||params[:user_id]).to_i)
    else
      @user = current_user
    end
  end

  def show_skills
    @show_skills =  (((User.teamleader_users(current_user).include? @user) && (current_user.is_teamleader?)) ||
        current_user.is_manager? || current_user == @user) && !@user.is_manager?
  end
end