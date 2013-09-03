class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
   
    alias_action :create, :read, :update, :destroy, to: :crud

    if user.role? :admin
      can :manage, :all
    end
    if user.role? :client
      can :read, :all
      can :booking, Book
      can :crud, Book do |book|
        book.client_id == user.id
      end	
    end
    if user.role? :user
      can :read, :all
      can :booking, Book
    end    
  end
end
