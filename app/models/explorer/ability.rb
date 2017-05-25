module Explorer
    class Ability
      include CanCan::Ability

      def initialize(user)
        # Define abilities for the passed in user here. For example:
        #
        user ||= User.new # guest user (not logged in)
        if user.admin?
            can :manage, :all
        else
            can :read, Category
            can :read, User
            can :create, User
            can :manage, User, :user_id => user.id
            can :read, Event
            can :create, Event
            can :manage, Event, :user_id => user.id
            can :read, Venue
            can :create, Venue
            can :read, Organizer
            can :create, Organizer
            # can :manage, Organizer do |comp|
            #     comp.user_ids.include?(user.id)
            # end
        end
      end
    end
end