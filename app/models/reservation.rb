class Reservation < ActiveRecord::Base
  attr_accessible :employee_id, :from, :to, :user_id
end
