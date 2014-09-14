class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts
end

def role?(base_role)
  puts "base_role.to_s is #{base_role.to_s}"
  puts "user.role is #{user.role}"
  user.role == base_role.to_s

end