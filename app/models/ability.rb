class Ability
  include CanCan::Ability

  def initialize(user)

    if user.is_user?
      can :read, :except => UserChange
    end

    if user.is_teamleader?
      can :look, :dashboard
      can :manage, User.where(:department_id => user.department_id)
      can :read, UserChange
      can :manage, Report.where(:user_id => user.id)
    end

    if user.is_manager?
      can :look, :dashboard
      can :manage, User
      can :manage, Department
      can :restore, :departments
      can :restore, :skills
      can :read, UserChange
    end

    can :manage, :all if user.is_admin?
  end
end