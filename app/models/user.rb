class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_coupons
  has_many :coupons, through: :user_coupons
  has_many :orders

  def admin?
    self.role == "admin"
  end
end
