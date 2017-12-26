class Product < ActiveRecord::Base
  has_many :routine_products
  has_many :routines, through: :routine_products

  validates :name, presence: true
end
