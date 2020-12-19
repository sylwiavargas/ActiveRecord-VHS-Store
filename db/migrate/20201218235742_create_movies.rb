class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.integer :length
      t.boolean :female_director
      t.string :director
      t.string :description
    end
  end
end
