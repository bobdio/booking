class HomeController < ApplicationController
  def index
  	@home = Home.first
  	@title = @home[:title]
  end
end
