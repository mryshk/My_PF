# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(listener)
    can :manage, :all
    listener ||= Listener.new
    if listener.listener_type == 0
      can :manage, :all
      cannot :create, Album
    end
  end
end
