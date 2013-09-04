class Ability
  include CanCan::Ability

  def initialize(user)
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
    can :read, :all
    can :create, Booking
    can [:edit, :update, :delete], Booking do |booking|
      booking.client_id ==  @user.id
    end 
  end	

  def not_logged_in
    can [:login, :login_form, :activate_form, :activate], User
    can :read, :all
  end
end
