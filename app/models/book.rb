class Book < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :order_books
  has_many :orders, through: :order_books
end
