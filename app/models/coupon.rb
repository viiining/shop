class Coupon < ApplicationRecord
  validates :name, presence: true
  validates :discount_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :expiration_date, presence: true, date: { after_or_equal_to: Date.today }
  validates :max_usage_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :used_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end