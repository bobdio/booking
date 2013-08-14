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
		
end