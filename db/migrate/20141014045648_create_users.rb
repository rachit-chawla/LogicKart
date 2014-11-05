class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname, null: false
      t.string :mname, null: true
      t.string :lname, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.date :dob, null: false
      t.string :gender, null: false
      t.text :address, null: false
      t.string :phone, null: false
      t.string :user_type, default: 'user'
      
      t.timestamps
    end
  end
end
