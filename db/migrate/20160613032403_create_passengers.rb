class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :age_grade
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
