class AddTimestampsToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :created_at, :datetime
    add_column :rentals, :updated_at, :datetime
  end
end
