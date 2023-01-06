# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    # Referral abilities
    can :read, Referral, referred_by: user.id, active: true
    can [:create, :update, :assign_recruiter], Referral, referrer: user

    # User abilities
    can :manage, User, id: user.id

    return unless user.role_id == 1

    # Admin abilities
    can :manage, [Referral, Role, User]
  end
end
