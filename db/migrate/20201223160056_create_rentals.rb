class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.boolean :current
      t.integer :client_id
      t.integer :vhs_id
    end
  end
end
