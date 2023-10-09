class CouponsController < ApplicationController
  def index
    @coupon = Coupon.all
  end
end
