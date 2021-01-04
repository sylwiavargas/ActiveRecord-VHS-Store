require_relative '../tools/generic_helpers'


class Movie < ActiveRecord::Base
    has_many :vhs
    has_many :movie_genres
    has_many :genres, through: :movie_genres
    has_many :rentals, through: :vhs
    extend GenericHelpers
    include GenericHelpers
    
    def self.available_now
        Vhs.available_now.map(&:movie).uniq
    end

    def movie_clients
        self.rentals.map(&:client)
    end

    def self.most_clients
        movies_hash = self.all.each_with_object({}) { |movie, movie_hash| movie_hash[movie] = movie.movie_clients.uniq.count }
        movies_hash.max_by {|movie, client_count| client_count}[0]
    end



    def self.most_rentals
        self.movies_by_client_number.sort_by(&:last).pop(3).to_h.keys
    end

    def self.most_popular_female_director
        female_director_movies = Movie.where(female_director: true)
        rental_count = female_director_movies.each_with_object ({}) do |movie, rental_count|
            rental_count[movie] = movie.rentals.count
        end
        rental_count.max_by(&:last)[0].director
    end
    
    def self.movies_by_client_number
        vhs_hash = Vhs.count_vhs_by_client
        movie_by_client_count = vhs_hash.each_with_object({}) do |(vhs, times_rented), movie_hash|
                movie_hash[vhs.movie].nil? ? movie_hash[vhs.movie] = times_rented : movie_hash[vhs.movie] += times_rented
        end
    end

    def self.newest_first
        self.order(year: :desc)
    end

    def self.longest
        self.order(length: :desc)
    end

    def recommendation
        puts Faker::SlackEmoji.emoji.emoji + " " + self.title
        puts "Description: #{self.description}"
        puts "Length: #{self.length}"
        puts "Director: #{self.director}"
        puts "Released in: #{self.year}"
    end
    
    def self.surprise_me
        puts Movie.all.sample.recommendation
    end

    def report_stolen
        vhs_to_delete = Vhs.available_now.find{|vhs| vhs.movie_id == self.id}
        vhs_to_delete.destroy
        puts "THANK YOU FOR YOUR REPORT. WE WILL LAUNCH AN INVESTIGATION."
    end
end