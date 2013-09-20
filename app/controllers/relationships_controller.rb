class RelationshipsController < ApplicationController
before_filter :authenticate_user!
authorize_resource

def show
  @user = User.find current_user.id	
end

def create
	@user = User.find params[:relationship][:user_id]
  params[:relationship][:client_id] = current_user.id
  @relation = Relationship.new params[:relationship]
  if @relation.save
  	flash[:success] = "Subscription was successful saved!"
  	#потрібно буде ще зробити відсилання емайла юзеру
    redirect_to user_bookings_path(@user)
  else
    flash[:error] = "Subscribed not saved. Try again"
    redirect_to user_bookings_path(@user)
  end	
end

def confirm_client
  if current_user.confirm_client params[:id]
  	flash[:success] = "Confirmation was successful saved!" 
    redirect_to relationship_path current_user
  else
    flash[:error] = "Confirmation didn't save!"
    redirect_to relationship_path current_user
  end 
end

def block_client
  if current_user.block_client params[:id]
  	flash[:success] = "Blocking was successful saved!" 
    redirect_to relationship_path current_user
  else
    flash[:error] = "Blocking didn't save!"
    redirect_to relationship_path current_user
  end 
end

#end class
end