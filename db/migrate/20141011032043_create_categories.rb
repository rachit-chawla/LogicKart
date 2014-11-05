class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category_id, null: false
      t.string :category_name, null: false
      t.string :product_type, null: false
      t.timestamps
    end
  end
end
