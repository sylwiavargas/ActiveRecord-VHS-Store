class Vhs < ActiveRecord::Base
    belongs_to :movie
    has_many :rentals
    has_many :clients, through: :rentals

    def number_of_rentals
        self.rentals.count
    end

    def self.most_used
        most_used = self.all.sort_by{|vhs| vhs.number_of_rentals}.reverse[0..2]
        most_used.each{|vhs| puts "serial number: #{vhs.serial_number} | title: #{vhs.movie.title}"}
    end

    def self.all_movies
        self.all.map{|vhs| vhs.movie}.to_set
    end

    def self.all_genres
        movies = self.all_movies
        movies.map{|movie| movie.genres}.flatten.to_set
    end

    def self.available_now
        binding.pry
        # self.all.select{|vhs| }
    end

    def self.hot_from_the_press(args_hash, genre_str)
        movie_object = Movie.create(args_hash)
        genre_object = Genre.find_by(name: genre_str) || Genre.create(name: genre_str)
        mg = MovieGenre.create(movie_id: movie_object.id, genre_id: genre_object.id)
        3.times{Vhs.create(movie_id: movie_object.id, serial_number: 1)}
    end
end