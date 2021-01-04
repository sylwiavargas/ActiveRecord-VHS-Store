class AddTimestampsToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :created_at, :datetime
    add_column :genres, :updated_at, :datetime
  end
end
