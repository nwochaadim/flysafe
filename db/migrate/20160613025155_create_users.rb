class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :type
      t.integer :age
      t.references :booking, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
