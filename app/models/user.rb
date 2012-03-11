class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :trackable, :validatable
#         , :confirmable
=======
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
>>>>>>> 1776c893a53187efdc9ae7a88c9972674d59f980

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_and_belongs_to_many :roles
  has_many :comments
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

end
