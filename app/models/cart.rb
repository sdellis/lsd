class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  attr_accessible :line_items;
end
