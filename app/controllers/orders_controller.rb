class OrdersController < ApplicationController
  before_action :authenticate_user!
  def create
    selected_coupon = session[:selected_coupon]
    user_coupon_id = nil
    @cart = session[:order_info]
  
    if @cart.present?
      total_price = calculate_total_price(@cart)
  
      if selected_coupon.present?
        user_id = selected_coupon["user_id"]
        user_coupon_id = selected_coupon["id"]
  
        @order = current_user.orders.build(
          amount: total_price,
          user_id: current_user.id,
          user_coupon_id: user_coupon_id
        )
      else
        @order = current_user.orders.build(amount: total_price, user_coupon_id: user_coupon_id)
      end
  
      if @order.save
        session[:order_info] = nil
        flash[:notice] = "訂單建立成功！"
        redirect_to books_path
      else
        flash[:alert] = "訂單建立失敗請確認！"
        render 'new'
      end
    else
      flash[:alert] = "購物車是空的！請選擇商品再建立訂單。"
      redirect_to cart_path
    end
  end

  private
  def calculate_total_price(cart)
    total_price = 0
    cart_items = cart["items"]
  
    cart_items.each do |item|
      book = Book.find(item["book_id"])
      quantity = item["quantity"]
      total_price += book.price * quantity
    end
  
    if session[:selected_coupon].present?
      selected_coupon = session[:selected_coupon]
      discount_amount = selected_coupon["discount_amount"]
      total_price -= discount_amount
    end
  
    total_price
  end
end

