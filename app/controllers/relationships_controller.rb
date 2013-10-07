class RelationshipsController < ApplicationController
helper_method :sort_column, :sort_direction   
before_filter :authenticate_user!
authorize_resource

def index
	@user_type = params[:user_type]
  @users = filter_users @user_type
  @user_types = ['All users', 'clients', 'employees']
  @user_types_for_select = @user_types.map.with_index.to_a
end	

def show
  @user = User.find current_user.id
  @list = [];
	@list = @user.clients.paginate(page: params[:page], per_page: 5) if @user.role == "employee"
  @list = @user.inverse_clients.paginate(page: params[:page], per_page: 5) if @user.role == "client"	
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
private 
  def filter_users(user_type)
    role = :client if user_type.to_i == 1
    role = :employee if user_type.to_i == 2    
    if role 
      @users = User.where(" role = ? AND name like ?","#{role}","%#{params[:search]}%").order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 5) 
    else
      @users = User.where("role != ? AND name like ?",:admin,"%#{params[:search]}%").order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 5)
    end 

  end	

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'name' 
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end  

#end class
end