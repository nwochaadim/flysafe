class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :password
      t.string :password_confirmation
      t.string :gender
      t.string :type
      t.references :booking, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
