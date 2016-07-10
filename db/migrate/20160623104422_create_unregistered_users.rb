class CreateUnregisteredUsers < ActiveRecord::Migration
  def change
    create_table :unregistered_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps null: false
    end
  end
end
