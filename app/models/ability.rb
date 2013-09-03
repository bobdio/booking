class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    if user
      @user = user
      admin  if @user.role == "admin"
      client if @user.role == "client"
    else
      not_logged_in
    end	
  end

  def admin
    can :manage, :all
  end

  def client
    can :booking, Booking
    can :crud, Booking do |booking|
      booking.client_id == @user.id 
    end	
  end	

  def not_logged_in
    can [:login, :login_form, :activate_form, :activate], User
    can :read, :all
    can :booking, Booking
  end
end
