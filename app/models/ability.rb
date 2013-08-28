class Ability
  include CanCan::Ability

  def initialize(user)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# handling user privs
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    user ||= User.new # guest user (not logged in)
    user.role ||= Role.new

    if user.admin?
      can :manage, Conference
      can :manage, Page
      can :manage, Pagecat
      can :manage, Plenary
      can :manage, Workshop
      can :manage, Board
      can :manage, Idea

      can :manage, Submission

    elsif user.attendee?
    	can [:new, :create], Submission do |s|
    		!user.submitted? and user.registered?
    	end

			# Board Auth for attendee
			can :create, Board do |b|
				user.registered?
			end
			can [:edit, :update], Board do |b|
				b.user == user
			end

			# Ideas for a board auth for attendee
			can :create, Idea do |i|
				user.registered?
			end
			can [:edit, :update], Idea do |i|
				i.user == user
			end

       # Workshop abilities for attendee
        can :attend, Workshop do |w|
            w.has_registered_for_day? user
        end
        can [:read, :unattend], Workshop
    	can :read, Conference
    	can :read, Submission do |s|
    		s.user == user || s.approved?
    	end

    	# Propose an idea
#    	can [:create], Idea if user.registered?
    elsif user.reviewer?
    	# Write permissions for reviewer here
    	can :read, Submission do |s|
				s.approved? or ReviewerSubmission.where(:submission_id => s, :user_id => user).size > 0
    	end
    	can [:new, :create], Score do |s|
				ReviewerSubmission.where(:submission_id => s.submission, :user_id => user).size > 0
    	end
    else
        # Write persmissions for public here
        cannot :create, Board
        cannot :create, Idea
    end




    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
