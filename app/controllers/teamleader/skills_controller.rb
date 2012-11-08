class Teamleader::SkillsController < Teamleader::AppTeamleaderController
  before_filter -> {@skills = current_user.skill_user_relations.includes(:skills)}, :except => [:update]
  before_filter -> {@skill_list = Skill.all.map(&:name)}

  def show

  end

  def edit

  end

  def update

  end
end