class HomeController < ApplicationController
	#authorize_resource
  def index
  	@home = Home.first
  	@title = @home[:title]
  end
end
