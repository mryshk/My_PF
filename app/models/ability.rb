# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(listener)

    listener ||= Listener.new
    if listener.listener_type == 0
      can :read, Album
      can :read, AlbumMusic

    else
      can :manage, :all
    end
  end
end
