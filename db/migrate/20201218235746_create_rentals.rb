class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.integer :client_id
      t.integer :vhs_id
      t.boolean :current
      t.timestamps
    end
  end
end
