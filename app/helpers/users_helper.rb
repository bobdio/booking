module UsersHelper
	
	def flash_messages
    if flash.any?
    	messages = ""
	    flash.each do |key, value| 
				messages += content_tag(:div, value, class: "success alert alert-#{key}")
			end 
			messages.html_safe
		end		
	end
		
	# Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end	
end