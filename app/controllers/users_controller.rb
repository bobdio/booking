class UsersController < ApplicationController
  
  #authorize_resource

  def index
    @users = User.all
  end
  
  def new
  	@user = User.new 
  end
  def show
    @user = User.find params[:id] 
  end  

  def create
    @user = User.new params[:user]
    if @user.save
      flash[:success] = "Welcome to the BookingSystem!"
      redirect_to users_path
    else
      render 'new'
    end
  end	

  def edit
    @user = User.find params[:id]
  end  

  def update
    @user = User.find params[:id]
    if @user.update_attributes(params[:user])
      flash[:success] = "Сhanges have been successfully saved! :-)"
      redirect_to users_path
    else
      render 'edit'
    end 
  end 

  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:success] = "User successfully deleted! :-("
    redirect_to users_path
  end 
end