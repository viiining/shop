class ChangeColumnToOrder < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :user_coupon_id, :bigint, null: true
  end
end
