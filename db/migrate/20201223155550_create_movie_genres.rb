class CreateMovieGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_genres do |t|
      t.integer :movie_id
      t.integer :genre_id
    end
  end
end
