module HomeHelper

  def render_title
    return @title if defined?(@title)
    "My BooKing SySteM" 
  end	
end
