class Order < ApplicationRecord
  belongs_to :user
  belongs_to :user_coupon
  has_many :order_books
  has_many :books, through: :order_books
end
