class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true, uniqueness: true
  attr_accessible :name, :password, :password_confirmation
end
