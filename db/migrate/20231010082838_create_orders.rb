class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :amount
      t.references :user, null: false, foreign_key: true
      t.references :user_coupon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
