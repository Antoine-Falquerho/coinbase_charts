class CreateBitcoins < ActiveRecord::Migration
  def change
    create_table :bitcoins do |t|
      t.integer :buy_price
      t.integer :sell_price

      t.timestamps
    end
  end
end
