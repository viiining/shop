class Admin::CouponsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :find_coupon, only: [:edit, :update, :destroy]

  def index
    @coupons = Coupon.all
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      redirect_to coupons_path, notice: "新增成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @coupon.update(coupon_params)
      redirect_to coupons_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @coupon.destroy
    redirect_to coupons_path, notice: "已刪除"
  end

  private
  def find_coupon
    @coupon = Coupon.find_by(id: params[:id])
  end

  def coupon_params
    params.require(:coupon).permit(:name, :discount_amount, :expiration_date, :max_usage_count, :used_count, :is_used)
  end
end
