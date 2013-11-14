class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.float :amount
      t.integer :quantity
      t.integer :user_id
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end
  end
end
