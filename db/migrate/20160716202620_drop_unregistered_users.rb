class DropUnregisteredUsers < ActiveRecord::Migration
  def up
    drop_table :unregistered_users
  end

  def down
    create_table :unregistered_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps null: false
    end
  end
end
