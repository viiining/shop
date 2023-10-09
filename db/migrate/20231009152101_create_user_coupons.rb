class CreateUserCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :user_coupons do |t|
      t.references :user, null: false, foreign_key: true
      t.references :coupon, null: false, foreign_key: true
      t.integer :used_count

      t.timestamps
    end
  end
end
