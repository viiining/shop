class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.integer :discount_amount
      t.date :expiration_date
      t.integer :max_usage_count
      t.integer :used_count, default: 0
      t.boolean :is_used, default: false

      t.timestamps
    end
  end
end
