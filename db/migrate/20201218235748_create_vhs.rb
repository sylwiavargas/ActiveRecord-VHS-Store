class CreateVhs < ActiveRecord::Migration[5.2]
  def change
    create_table :vhs do |t|
      t.string :serial_number
      t.integer :movie_id
    end
  end
end
