require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "購物車基本功能" do
    it "把書加進購物車裡，購物車會有書" do
      cart = Cart.new
      cart.add_item 1
      expect(cart.empty?).to be false
    end

    it "如果加了同一本書到購物車裡，購買項目（CartItem）並不會增加，但書的數量會改變" do
      cart = Cart.new                             
      2.times { cart.add_item(1) }                
      3.times { cart.add_item(2) }                
      4.times { cart.add_item(3) }                

      expect(cart.items.length).to be 3           
      expect(cart.items.first.quantity).to be 2
      expect(cart.items.second.quantity).to be 3 
    end

    it "書可以放到購物車裡，也可以移除" do
      cart = Cart.new
      book1 = Book.create(title: "Hello")
      book2 = Book.create(title: "World")

      2.times { cart.add_item(book1.id) }
      3.times { cart.add_item(book2.id) }

      expect(cart.items.first.book_id).to be book1.id
      expect(cart.items.second.book_id).to be book2.id
      expect(cart.items.first.book).to be_a Book
    end

    it "算整台購物車的總消費金額" do
      cart = Cart.new
      book1 = Book.create(title: "Hello", price: 200)
      book2 = Book.create(title: "World", price: 300)

      2.times {
        cart.add_item(book1.id)
        cart.add_item(book2.id)
      }

      expect(cart.total_price).to be 1000      
    end

    it "可搭配優惠券使用折扣" do
      cart = Cart.new
      book1 = Book.create(title: "Hello", price: 200)
      coupon = Coupon.new(name: "DISCOUNT100", discount_amount: 100)
  
      2.times {
        cart.add_item(book1.id)
      }
      
      cart.apply_coupon(coupon)
  
      expect(cart.total_price).to eq(300)
    end
  end

  describe "購物車進階功能" do
    it "可以將購物車內容轉換成 Hash，存到 Session 裡" do
      cart = Cart.new
      2.times { cart.add_item(2) }
      3.times { cart.add_item(5) }

      expect(cart.serialize).to eq session_hash      
    end

    it "可以把 Session 的內容（Hash 格式），還原成購物車的內容" do
      cart = Cart.transfer_hash(session_hash)

      expect(cart.items.first.book_id).to be 2
      expect(cart.items.first.quantity).to be 2
      expect(cart.items.second.book_id).to be 5
      expect(cart.items.second.quantity).to be 3
    end
  end

  private
  def session_hash
    {
      "items" => [
        { "book_id" => 2, "quantity" => 2 },
        { "book_id" => 5, "quantity" => 3 }
      ]
    }
  end
end
