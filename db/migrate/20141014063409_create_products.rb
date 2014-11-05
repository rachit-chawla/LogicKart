class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_id, null: false
      t.string :product_name, null: false
      t.string :product_price, null: false
      t.timestamps
    end
  end
end
