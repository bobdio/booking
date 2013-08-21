module BooksHelper
  
  #return date in javascript format 
  def rb_to_js(date)
    date.strftime("%Y-%m-%dT%H:%M:%S")
  end

  def event_title(client)	
    "#{client[:lastname]} #{client[:name].first}."
  end
end	