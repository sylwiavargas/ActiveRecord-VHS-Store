class Movie < ActiveRecord::Base
    has_many :movie_genres
    has_many :genres, through: :movie_genres
    has_many :vhss
    has_many :rentals, through: :vhss

end