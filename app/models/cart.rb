class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items

  def total_quantity
    cart_items.sum(:quantity)
  end

  def total_price
    cart_items.sum(&:sub_total_price)
  end
end
