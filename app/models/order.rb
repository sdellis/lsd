class Order < ActiveRecord::Base
  attr_accessible :address, :contact_me, :email, :name
end
