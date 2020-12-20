class Movie < ActiveRecord::Base

    has_many :movie_genres
    has_many :genres, through: :movie_genres
    has_many :vhs
    has_many :rentals, through: :vhs

    def self.available_now
        Vhs.available_now.map(&:movie).to_set
    end

    def number_of_rentals
        self.vhs.sum{|vhs| vhs.rentals.count}
    end

    def self.most_rentals
        self.all.sort_by{|movie| movie.number_of_rentals}[0..2]
    end

    def number_of_clients
        self.vhs.sum{|vhs| vhs.number_of_clients}
    end

    def self.most_clients
        self.all.max_by{|movie| movie.number_of_clients}
    end

    def self.newest_first
        self.all.sort_by(&:year).reverse
    end

    def self.longest
        self.all.sort_by(&:length).reverse
    end

    def recommendation
        random_emoji = ["🥬", "🔥", "⭐️"].sample
        puts random_emoji + " title: #{self.title} \n description: #{self.description} \n length: #{self.length} \n director: #{self.director} \n year: #{self.year}"
    end

    def self.surprise_me
        self.all.sample.recommendation
    end

    def report_stolen
        Vhs.available_now.select{|vhs| vhs.movie == self}.sample.destroy
        puts "THANK YOU FOR YOUR REPORT. WE WILL LAUNCH AN INVESTIGATION."
    end

end