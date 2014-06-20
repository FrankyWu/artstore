class Cart < ActiveRecord::Base
  has_many :cart_items, :dependent => :destroy
  has_many :items, :through => :cart_items, :source => :product
 
 
  def add_product_to_cart(product , amount)
    cart_item = cart_items.build
    cart_item.product = product
    cart_item.quantity = amount
    cart_item.save
  end

  def delete_item_from_cart(product)
    items.delete(product)
  end

  def total_price
    items.inject(0) { |sum, item|  sum + item.price}
  end
end
