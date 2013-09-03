class User < ActiveRecord::Base

  ROLES = %w[admin client user]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable 
  
  has_many :bookings, dependent: :destroy

  
end