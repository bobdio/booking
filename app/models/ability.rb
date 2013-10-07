class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      @user = user
      #@user.roles.each { |role| send(role) if respond_to? role }
      admin if @user.role == "admin"
      employee if @user.role == "employee"
      client if @user.role == "client"
    else
      not_logged_in
    end	
  end

  def admin
    can :manage, :all
    can :manage, Relationship
  end

  def client
    can :read, :all
    can :create, Booking
    can [:edit, :update, :delete], Booking do |booking|
      booking.client_id ==  @user.id && booking.to > Time.now
    end 
  end

  def employee
    can :read, :all
    can :create, Booking
    can [:edit, :update, :delete], Booking do |booking|
      booking.client_id ==  @user.id
    end 
    can [:show, :create, :confirm_client, :block_client], Relationship
  end	

  def not_logged_in
    can :read, :all
  end
end
