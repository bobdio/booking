class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      @user = user
      admin_rights  if @user.role == "admin"
      user_rights if @user.role == "user"
      client_rights if @user.role == "client"
    else
      not_logged_in
    end	
  end

  def admin_rights
    can :manage, :all
  end

  def client_rights
    can :read, :all
    can :create, Booking
    can [:edit, :update, :delete], Booking do |booking|
      booking.client_id ==  @user.id && booking.to > Time.now
    end 
  end

  def user_rights
    can :read, :all
    can :create, Booking
    can [:edit, :update, :delete], Booking do |booking|
      booking.client_id ==  @user.id
    end 
    can :manage, Relationship
  end	

  def not_logged_in
    can :read, :all
  end
end
