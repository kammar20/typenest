# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.persisted?
      can :manage, Blog, user_id: user.id
      can :manage, Comment, user_id: user.id
      can :read, Blog
    else
      can :read, Blog
    end
  end
end
