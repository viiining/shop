class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @coupon = Coupon.all
  end

  def apply_coupon
    coupon_id = params[:coupon_id]

    @coupon = Coupon.all

    selected_coupon = @coupon.find { |coupon| coupon.id.to_s == coupon_id }

    if selected_coupon.present?
      session[:selected_coupon] = selected_coupon
    end

    redirect_to cart_path(params[:id])
  end

  def cancel_coupon
    session[:selected_coupon] = nil
    redirect_to cart_path(params[:id])
  end

  def add
    @cart.add_item(params[:id])
    session[:order_info] = @cart.serialize

    redirect_to books_path, notice: "已加入購物車"
  end

  def destroy
    session[:order_info] = nil
    session[:selected_coupon] = nil
    redirect_to books_path, notice: "購物車已清空"
  end
end
