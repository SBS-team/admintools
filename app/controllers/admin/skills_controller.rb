class Admin::SkillsController < Teamleader::AppTeamleaderController
  before_filter :init_user
  before_filter -> {@skills = @user.skill_user_relations.includes(:skill)}
  before_filter -> {@skill_list = Skill.all}

  def show

  end

  def edit

  end

  def update
    (params[:skill][:score] || []).each { |skill| @user.skill_user_relations.where(:skill_id => skill.first).first_or_initialize.update_attributes(:score => skill.last) }
    (params[:skill][:delete] || []).each { |skill| @user.skill_user_relations.where(:skill_id => skill.first).destroy_all }
    redirect_to admin_user_skills_path(params[:user_id])
  end

private
  def init_user
     redirect_to root_path unless (@user = User.find(params[:user_id]))
  end
end