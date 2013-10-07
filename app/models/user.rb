class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  include RoleModel
  ROLES = %w[admin client employee]
  #roles_attribute :roles_mask

  roles :admin, :client, :employee

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable 
  
  before_create :set_default_role

  has_many :bookings, dependent: :destroy
  
  has_many :relationships
  has_many :clients, through: :relationships

  has_many :inverse_relationships, class_name: "Relationship", foreign_key: "client_id"
  has_many :inverse_clients, through: :inverse_relationships, source: :user
  
  

  def confirm_client?(client_id)
    res = relationships.select(:confirm).where(client_id: client_id).first
    return true if res && res.confirm == 1
    false
  end

  def confirm_client(client_id)
    res = relationships.where(client_id: client_id).first
    res.confirm = 1
    if res.save
      return true
    end  
    false  
  end
  
  def block_client(client_id)
    res = relationships.where(client_id: client_id).first
    res.confirm = 0
    if res.save
      return true
    end  
    false  
  end

  private

    def set_default_role
      self.role ||= 'client'
    end  
end