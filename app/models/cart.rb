class Cart
  attr_reader :items, :coupon

  def initialize(items = [])
    @items = items
    @coupon = nil
  end

  def add_item(book_id)
    found_item = items.find { |item| item.book_id == book_id }

    if found_item
      found_item.increment
    else
      @items << CartItem.new(book_id)
    end
  end

  def empty?
    @items.empty?
  end

  def apply_coupon(coupon)
    if coupon.discount_amount <= total_price
      @coupon = coupon
    else
      @coupon = nil
    end
  end

  def total_price
    total = items.sum(&:price)
    if coupon
      total -= coupon.discount_amount
    end
    total
  end

  def serialize
    all_items = items.map { |item|
      { "book_id" => item.book_id, "quantity" => item.quantity }
    }

    { "items" => all_items }
  end

  def self.transfer_hash(hash)
    if hash.nil?
      new []
    else
      new hash["items"].map { |item_hash|
        CartItem.new(item_hash["book_id"], item_hash["quantity"])
      }
    end
  end
end