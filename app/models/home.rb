# == Schema Information
#
# Table name: homes
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Home < ActiveRecord::Base
  attr_accessible :description,  :title
end
