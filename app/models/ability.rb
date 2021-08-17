class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :patients_by_status_by_month, :surgeries_by_status_by_month, :to => :read
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
       if user.is_role(User::ADMINISTRATOR)
         can :manage, :all
         cannot :create, [Patient, PhoneCall, Admission, AdmissionStatus, OrSchedule, SurgicalService]
         cannot :edit, [PhoneCall, Admission, AdmissionStatus, OrSchedule, SurgicalService]
       end
       if user.is_role(User::LIAISON_OFFICER)
         can :manage, Patient
         can :manage, [Admission, PhoneCall, AdmissionStatus]
       end
       if user.is_role(User::OR_USER)
         can :read, Patient
         can :manage, SurgicalService
         can :manage, OrSchedule
         cannot [:edit, :destroy], OrSchedule
         can [:edit, :destroy], OrSchedule do |os|
           os.surgical_service.blank?
         end
       end

      if user.is_role(User::QUALITY)
        can :read, :all
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
