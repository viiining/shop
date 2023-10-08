require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe "購物車基本功能" do
    it "每個 Cart Item 都可以計算自己的總額（小計）" do
      book1 = Book.create(title: "Hello", price: 200)
      book2 = Book.create(title: "World", price: 300)
  
      cart = Cart.new
      2.times { cart.add_item(book1.id) }
      3.times { cart.add_item(book2.id) }
      4.times { cart.add_item(book1.id) }
  
      expect(cart.items.first.price).to be 1200
      expect(cart.items.second.price).to be 900
    end
  end

end
