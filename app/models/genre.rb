require_relative '../tools/generic_helpers'

class Genre < ActiveRecord::Base
    has_many :movie_genres
    has_many :movies, through: :movie_genres
    include GenericHelpers

    #Original
    # def self.most_popular
    #     genres_hash = Movie.all.each_with_object({}) do |movie, genres_hash|
    #         movie.genres.each do |genre|
    #             genres_hash[genre.name].nil? ? genres_hash[genre.name] = 1 : genres_hash[genre.name] += 1 
    #         end
    #     end
    #     genres_hash.sort_by(&:last).reverse.shift(5).to_h.keys
    # end

    def self.most_popular
        final_hash = Movie.all.each_with_object({}) do |movie, final_hash| 
            temporary_hash = make_hash_by_attribute(movie.genres, "name")
            final_hash.merge!(temporary_hash) {|key, oldval, newval| newval + oldval}
        end
        final_hash.sort_by(&:last).reverse.shift(5).to_h.keys
    end



    def average_movie_length
        self.movies.sum(&:length) / self.movies.count
    end

    def self.longest_movies
        genres_with_movies = Genre.all.select {|genre| !genre.movies.empty?}
            genres_hash = genres_with_movies.each_with_object({}) do |genre, genres_hash|
                genres_hash[genre] = genre.average_movie_length
            end
        genres_hash.max_by(&:last).first
    end
end