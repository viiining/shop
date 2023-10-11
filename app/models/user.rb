class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_coupons
  has_many :coupons, through: :user_coupons
  has_many :orders

  after_create :assign_coupons

  def admin?
    self.role == "admin"
  end

  def assign_coupons
    discount100 = Coupon.find_or_initialize_by(
      name: "DISCOUNT100",
      discount_amount: 100,
      expiration_date: Date.new(2023, 10, 31),
      max_usage_count: 2
    )
    discount100.save unless discount100.persisted?
  
    discount50 = Coupon.find_or_initialize_by(
      name: "DISCOUNT50",
      discount_amount: 50,
      expiration_date: Date.new(2023, 10, 31),
      max_usage_count: 5
    )
    discount50.save unless discount50.persisted?
  
    user_coupons.create(coupon: discount100)
    user_coupons.create(coupon: discount50)
  end  
end
