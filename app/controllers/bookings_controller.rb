class BookingsController < ApplicationController

	before_filter :authenticate_user!, except: :index
  load_and_authorize_resource
  def index
  	@user = User.find params[:user_id]
  	@books = @user.bookings
  	@relation = Relationship.new
  	@relation.user_id = @user.id 
  end

  def new 
    @user = User.find params[:user_id]
    @booking = @user.bookings.new
    @booking.from = "#{params[:date]}" + " 00:00"
    @booking.to = "#{params[:date]}" + " 00:00" 
  end	

  def create
  	@user = User.find params[:user_id]
  	params[:booking][:client_id] = current_user.id

  	@booking = @user.bookings.build(params[:booking])
    if @booking.save
    	flash[:success] = "Booking was successful saved!"
      redirect_to user_bookings_path(@user)
    else
      render 'new'
    end	
  end	

  def edit
    @user = User.find params[:user_id]	
    @booking = Booking.find params[:id]
    @booking[:from] = @booking[:from].strftime("%Y-%m-%d %H:%M")
    @booking[:to] = @booking[:to].strftime("%Y-%m-%d %H:%M")
  end	

  def update
  	@user = User.find params[:user_id]
  	@booking = @user.bookings.find params[:id]
  	if @booking.update_attributes(params[:booking])
      flash[:success] = "Сhanges have been successfully saved! :-)"
      redirect_to user_bookings_path(@user)
    else
      render 'edit'
    end  
  end	

  def destroy
  	@user = User.find params[:user_id]
    @booking = @user.bookings.find params[:id]
    if @booking.destroy
      flash[:success] = "booking successfully deleted! :-("
      redirect_to user_bookings_path(@user)
    else
      render 'edit'
    end  
  end
end
