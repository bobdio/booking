class BookingsController < ApplicationController

	before_filter :authenticate_user!, except: :index
  authorize_resource
  def index
  	@user = User.find params[:user_id]
  	@books = @user.bookings 
  end

  def new 
    @booking = Booking.new
    @user = User.find params[:user_id]
    @booking.user_id = params[:user_id]
    @booking.client_id = current_user.id
    @booking.from = "#{params[:date]}" + " 00:00"
    @booking.to = "#{params[:date]}" + " 00:00" 
  end	

  def create
    @booking = Booking.new params[:booking]
    if @booking.save
    	flash[:success] = "Booking was successful!"
      redirect_to user_bookings_path(User.find @booking.user_id)
    else
      render 'new'
    end	
  end	

  def edit
    @booking = Booking.find params[:id]
    @user = User.find params[:user_id]
    @booking[:from] = @booking[:from].strftime("%Y-%m-%d %H:%M")
    @booking[:to] = @booking[:to].strftime("%Y-%m-%d %H:%M")
  end	

  def update
  	@booking = Booking.find params[:id]
    params[:booking][:client_id] = current_user.id
  	if @booking.update_attributes(params[:booking])
      flash[:success] = "Сhanges have been successfully saved! :-)"
      redirect_to user_bookings_path(User.find @booking.user_id)
    else
      render 'edit'
    end  
  end	

  def destroy
    @booking = Booking.find params[:id]
    @booking.destroy
    flash[:success] = "book successfully deleted! :-("
    redirect_to user_bookings_path(User.find @booking.user_id)
  end
end
