class Relationship < ActiveRecord::Base
  #attr_accessible :confirm
  belongs_to :user
  belongs_to :client, class_name: "User"

end