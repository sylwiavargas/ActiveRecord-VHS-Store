class Genre < ActiveRecord::Base
    has_many :movie_genres
    has_many :movies, through: :movie_genres

    def number_of_movies
        self.movies.count
    end

    def self.most_popular
        self.sort_by{|genre| genre.number_of_movies}[0..4]
    end

    def average_movie_length
        sum = self.movies.sum(&:length)
        return 0 if sum == 0
        average = sum/self.movies.count.to_f.round(2)
    end

    def self.longest_movies
        self.all.max_by(&:average_movie_length)
    end
end