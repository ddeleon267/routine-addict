class Routine < ActiveRecord::Base
  belongs_to :user
  has_many :routine_products
  has_many :products, through: :routine_products
end
