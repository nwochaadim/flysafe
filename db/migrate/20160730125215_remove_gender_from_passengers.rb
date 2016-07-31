class RemoveGenderFromPassengers < ActiveRecord::Migration
  def change
    remove_column :passengers, :gender, :string
  end
end
