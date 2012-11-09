class Teamleader::SkillsController < Teamleader::AppTeamleaderController
  before_filter -> {@skills = current_user.skill_user_relations.includes(:skill)}
  before_filter -> {@skill_list = Skill.all}

  def show

  end

  def edit

  end

  def update
    (params[:skill][:score] || []).each { |skill| current_user.skill_user_relations.where(:skill_id => skill.first).first_or_initialize.update_attributes(:score => skill.last) }
    (params[:skill][:delete] || []).each { |skill| current_user.skill_user_relations.where(:skill_id => skill.first).destroy_all }
    redirect_to teamleader_skills_path
  end
end