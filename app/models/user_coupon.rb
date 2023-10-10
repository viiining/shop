class UserCoupon < ApplicationRecord
  belongs_to :user
  belongs_to :coupon
  has_many :orders
end
