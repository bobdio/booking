module HomeHelper

  def render_title
    return @title if defined?(@title)
    "BookingSystem" 
  end	
end
