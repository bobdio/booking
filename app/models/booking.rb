class Booking < ActiveRecord::Base
  #attr_accessible :client_id, :from, :to, :user_id
  belongs_to :user

end
