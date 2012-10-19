class Ability
  include CanCan::Ability

  def initialize(user)

    if user.role == "user"
      can :read, :except => [UserChange]
    end

    if user.role == 'teamleader'
      can :manage, User.where(:department_id => user.department_id)
      can :read, UserChange
    end

    if user.is_manager?
      can :manage, User
      can :manage, Department
      can :read, UserChange
    end

    can :manage, :all if user.role == "admin"

    # can :manage, User if user.role == 'manager'
    # can :manage, Department if user.role == 'manager'
    # can :manage, UserChange if user.role == 'manager'
  end
end