class AddTimestampsToMovieGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :movie_genres, :created_at, :datetime
    add_column :movie_genres, :updated_at, :datetime
  end
end
