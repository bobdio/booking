class BooksController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :booking]
  authorize_resource
  def booking
  	@user = User.find params[:id]
  	@books = @user.books 
  end

  def new 
    @book = Book.new
    @book.user_id = params[:user_id]
    @book.client_id = current_user.id
    @book.from = "#{params[:date]}" + " 00:00"
    @book.to = "#{params[:date]}" + " 00:00" 
  end	

  def create
    @book = Book.new params[:book]
    if @book.save
    	flash[:success] = "Booking was successful!"
      redirect_to controller: "books", action: "booking", id: @book.user_id
    else
      render 'new'
    end	
  end	

  def edit
    @book = Book.find params[:id]
    @book[:from] = @book[:from].strftime("%Y-%m-%d %H:%M")
    @book[:to] = @book[:to].strftime("%Y-%m-%d %H:%M")
  end	

  def update
  	@book = Book.find params[:id]
    params[:book][:client_id] = current_user.id
  	if @book.update_attributes(params[:book])
      flash[:success] = "Сhanges have been successfully saved! :-)"
      redirect_to controller: "books", action: "booking", id: @book.user_id
    else
      render 'edit'
    end  
  end	

  def destroy
    @book = Book.find params[:id]
    @book.destroy
    flash[:success] = "book successfully deleted! :-("
    redirect_to controller: "books", action: "booking", id: @book.user_id	
  end	
    
end